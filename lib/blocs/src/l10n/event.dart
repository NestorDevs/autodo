import 'dart:ui';

import 'package:equatable/equatable.dart';

import 'package:autodo/models/models.dart';

abstract class L10nEvent extends Equatable {
  const L10nEvent();

  @override
  List<Object> get props => [];
}

class LoadL10n extends L10nEvent {
  final Locale locale;

  const LoadL10n(this.locale);

  @override
  List<Object> get props => [locale];

  @override
  toString() => 'LoadL10n { locale: $locale }';
}

class SwitchUnits extends L10nEvent {
  final Units units;

  const SwitchUnits(this.units);

  @override
  List<Object> get props => [units];

  @override
  toString() => 'SwitchUnits { units: $units }';
}