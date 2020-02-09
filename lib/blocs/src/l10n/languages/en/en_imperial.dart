import 'package:intl/intl.dart';

import 'en_base.dart';

class EnImperialLocalization extends EnBaseLocalization {
  dateFormat(date) => (DateFormat("MM/dd/yyyy").format(date));
  String get fuelUnits => "gal";
  String get moneyUnits => "\$";
  String get moneyUnitsSuffix => "(USD)";
  String get distanceUnits => "miles";
  String get distanceUnitsShort => "(mi)";
  String get mileage => "Mileage";
}