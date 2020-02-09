import 'package:intl/intl.dart';

import 'en_base.dart';

class EnMetricLocalization extends EnBaseLocalization {
  dateFormat(date) => (DateFormat("dd/MM/yyyy").format(date));
  String get fuelUnits => "l";
  String get moneyUnits => "\$"; // what money units to use?
  String get moneyUnitsSuffix => "(USD)";
  String get distanceUnits => "km";
  String get distanceUnitsShort => "(km)";
  String get mileage => "Mileage";
}