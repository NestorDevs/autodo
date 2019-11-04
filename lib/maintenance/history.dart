import 'package:flutter/material.dart';
import 'package:autodo/blocs/todo.dart';

class MaintenanceHistory extends StatefulWidget {
  @override
  MaintenanceHistoryState createState() => MaintenanceHistoryState();
}

class MaintenanceHistoryState extends State<MaintenanceHistory> {
  @override 
  void initState() {
    // this will rebuild the widget each time that the TodoBLoC says to
    TodoBLoC().contentUpdated.stream.listen((data) {
      print('history');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TodoBLoC().items();
}
