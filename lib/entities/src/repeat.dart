import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:sembast/sembast.dart';

class RepeatEntity extends Equatable {
  final String id, name;
  final int mileageInterval;
  final Duration dateInterval;
  final List<String> cars;

  const RepeatEntity(
      this.id, this.name, this.mileageInterval, this.dateInterval, this.cars);

  @override
  List<Object> get props => [id, name, mileageInterval, dateInterval, cars];

  @override
  String toString() {
    return 'RepeatEntity { id: $id, name: $name, mileageInterval: $mileageInterval, dateInterval: $dateInterval, cars: $cars}';
  }

  static RepeatEntity fromSnapshot(DocumentSnapshot snap) {
    return RepeatEntity(
        snap.documentID,
        snap.data["name"] as String,
        snap.data["mileageInterval"] as int,
        (snap.data['dateInterval'] == null)
            ? null
            : Duration(days: snap.data["dateInterval"] as int),
        (snap.data['cars'] as List<dynamic>)?.cast<String>());
  }

  static RepeatEntity fromRecord(RecordSnapshot snap) {
    return RepeatEntity(
        (snap.key is String) ? snap.key : '${snap.key}',
        snap.value["name"] as String,
        snap.value["mileageInterval"] as int,
        (snap.value['dateInterval'] == null)
            ? null
            : Duration(days: snap.value["dateInterval"] as int),
        (snap.value['cars'] as List<dynamic>)?.cast<String>());
  }

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "mileageInterval": mileageInterval,
      "dateInterval": dateInterval?.inDays,
      "cars": cars
    };
  }
}
