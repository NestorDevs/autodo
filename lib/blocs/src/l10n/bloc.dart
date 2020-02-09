import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autodo/models/models.dart';
import 'package:autodo/blocs/src/l10n/languages/en/en.dart';
import 'package:flutter/widgets.dart';
import 'event.dart';
import 'state.dart';

class L10nBloc extends Bloc<L10nEvent, L10nState> {
  @override
  L10nState get initialState => L10nNotLoaded();

  @override
  Stream<L10nState> mapEventToState(L10nEvent event) async* {
    if (event is LoadL10n) {
      yield* _mapLoadToState(event);
    } else if (event is SwitchUnits) {
      yield* _mapSwitchToState(event);
    }
  }

  Stream<L10nState> _mapLoadToState(LoadL10n event) async* {
    if (state is L10nLoaded) {
      // don't change the units preference, but the language can change if the
      // system preference changes.
      // currently not going to do anything
    } else {
      if (event.locale == null) {
        yield L10nNotLoaded();
      } else if (event.locale.countryCode.toLowerCase().contains('us')) {
        yield L10nLoaded(EnImperialLocalization());
      } else {
        yield L10nLoaded(EnMetricLocalization());
      }
    }
  }

  Stream<L10nState> _mapSwitchToState(event) async* {
    // TODO: need to consider past language before switching units
    if (event.units == Units.METRIC) {
      yield L10nLoaded(EnMetricLocalization());
    } else if (event.units == Units.IMPERIAL) {
      yield L10nLoaded(EnImperialLocalization());
    }
  }
}

/// An abstraction to the call for the currently loaded localization object
AutodoLocalization currentL10n(BuildContext context) =>
  (BlocProvider.of<L10nBloc>(context).state as L10nLoaded).localization;