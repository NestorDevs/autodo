import 'package:flutter/material.dart';

import 'package:autodo/models/models.dart';
import 'en/en.dart';

class AutodoLocalizationsDelegate
    extends LocalizationsDelegate<AutodoLocalization> {
  const AutodoLocalizationsDelegate();

  @override
  Future<AutodoLocalization> load(Locale locale) async {
    if (locale.countryCode.toLowerCase().contains('us')) {
      return EnImperialLocalization(); // imperial units
    } else {
      return EnMetricLocalization(); // make one with metric units
    }
  }

  @override
  bool shouldReload(AutodoLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode.toLowerCase().contains("en");
}