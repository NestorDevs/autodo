import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autodo/items/items.dart';
import 'package:flutter/material.dart';
import 'package:autodo/maintenance/todocard.dart';
import 'package:autodo/blocs/subcomponents/subcomponents.dart';
import 'package:autodo/blocs/notifications.dart';

class TodoBLoC extends BLoC {
  bool active = false;
  String searchTerm;
  StreamController contentUpdated = StreamController.broadcast(); // ignore: close_sinks
  // search criteria: returns any todo item that contains the query in its name
  // maybe extend this to allow searching by other options??
  var filter = (item, query) => item.name.toLowerCase().contains(query.toLowerCase());

  StreamController itemStream = StreamController.broadcast(); // ignore: close_sinks

  void onNewSnapshot(dynamic snap) {
    print('new snap');
    if (!active || snap.hasError || !snap.hasData || 
        snap.data.documents.length == 0) {
      itemStream.add(snap);
    } else {
      return snap.data.documents
        .where((item) => filter(item, searchTerm))
        .toList();
    }
  }

  void init() {
    firebaseStream('todos').listen(onNewSnapshot);
  }

  @override
  Widget buildItem(dynamic snapshot, int index) {
    bool first = index == 0;
    var name = (first) ? 'Upcoming: ' : ''; // TODO: move this logic to the card
    name += snapshot.data['name'];
    var date;
    if (snapshot.data.containsKey('dueDate') && snapshot.data['dueDate'] != null)
      date = snapshot.data['dueDate'].toDate();
    var mileage = snapshot.data['dueMileage'];
    var item = MaintenanceTodoItem(
      ref: snapshot.documentID,
      name: name,
      dueDate: date,
      dueMileage: mileage,
      repeatingType: snapshot.data['repeatingType'],
      tags: snapshot.data['tags']
    );
    return MaintenanceTodoCard(item: item, emphasized: first);
  }

  @override
  List sortItems(List items) {
    return items..sort((a, b) {
      var aDate = a.data['dueDate'] ?? 0;
      var bDate = b.data['dueDate'] ?? 0;
      var aMileage = a.data['dueMileage'] ?? 0;
      var bMileage = b.data['dueMileage'] ?? 0;
       
      if (aDate == 0 && bDate == 0) {
        // both don't have a date, so only consider the mileages
        if (aMileage > bMileage) return 1;
        else if (aMileage < bMileage) return -1;
        else return 0;
      } else if (aMileage == 0 && bMileage == 0) {
        // both don't have a mileage, so only consider the dates
        if (aDate < bDate) return 1;
        else if (aDate > bDate) return -1;
        else return 0;
      } else {
        // there should be a function here to translate mileage to dates
        return 0;
      }
    });
  }

  StreamBuilder items() {
    return buildList('todos', itemStream.stream);
  }

  Future<void> scheduleNotification(MaintenanceTodoItem item) async {
    if (item.dueDate != null) {
      var id = await NotificationBLoC().scheduleNotification(
        datetime: item.dueDate,
        title: 'Maintenance ToDo Due Soon: ${item.name}',
        body: ''
      );
      item.notificationID = id;
    }
  }

  Future<void> push(MaintenanceTodoItem item) async {
    await scheduleNotification(item);
    pushItem('todos', item);
  }

  void edit(MaintenanceTodoItem item) {
    editItem('todos', item);
  }

  void delete(MaintenanceTodoItem item) {
    deleteItem('todos', item);
  }

  void undo() {
    undoItem('todos');
  }

  Future<WriteBatch> addUpdate(WriteBatch batch, MaintenanceTodoItem item) async {
    DocumentReference userDoc = FirestoreBLoC().getUserDocument();
    DocumentReference ref = userDoc
        .collection('todos')
        .document(item.ref);
    batch.setData(ref, item.toJSON());
    return batch;
  }

  void listenForActive(dynamic index) {
    print(index);
    active = index == 0;
  }

  void listenForSearch(dynamic value) {
    print(value);
    searchTerm = value;
    // contentUpdated.add(true);
  }

  // Make the object a Singleton
  static final TodoBLoC _bloc = TodoBLoC._internal();
  factory TodoBLoC() {
    return _bloc;
  }
  TodoBLoC._internal();
}
