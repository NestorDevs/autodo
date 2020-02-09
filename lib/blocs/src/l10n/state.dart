import 'package:equatable/equatable.dart';

import 'package:autodo/models/models.dart';

abstract class L10nState extends Equatable {
  const L10nState();

  @override
  List<Object> get props => [];
}

class L10nNotLoaded extends L10nState {}

class L10nLoaded extends L10nState {
  final AutodoLocalization localization;

  const L10nLoaded(this.localization);

  @override
  List<Object> get props => [localization];

  @override
  toString() => 'L10nLoaded { localization: $localization }';
}