import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:charts_flutter/flutter.dart';

import 'package:autodo/blocs/barrel.dart';
import 'package:autodo/models/barrel.dart';

class MockRefuelingsBloc extends Mock implements RefuelingsBloc {}

void main() {
  group('EfficiencyStatsBloc', () {
    test('Null Assertion', () {
      expect(() => EfficiencyStatsBloc(refuelingsBloc: null), throwsAssertionError);
    });
    final refueling = Refueling(
      id: '0',
      date: DateTime.fromMillisecondsSinceEpoch(0),
      efficiency: 1.0,
    );
    blocTest('LoadEfficiencyStats',
      build: () {
        final refuelingsBloc = MockRefuelingsBloc();
        whenListen(refuelingsBloc, Stream.fromIterable([RefuelingsLoaded([refueling])]));
        when(refuelingsBloc.state).thenAnswer((_) => RefuelingsLoaded([refueling]));
        return EfficiencyStatsBloc(refuelingsBloc: refuelingsBloc);
      },
      act: (bloc) async => bloc.add(LoadEfficiencyStats()),
      expect: [
        EfficiencyStatsLoading(),
        EfficiencyStatsLoaded([]) // no graph with only one point
      ],
    );
    blocTest('UpdateDrivingDistanceData', 
      build: () {
        final refuelingsBloc = MockRefuelingsBloc();
        whenListen(refuelingsBloc, Stream.fromIterable([RefuelingsLoaded([refueling])]));
        when(refuelingsBloc.state).thenAnswer((_) => RefuelingsLoaded([refueling]));
        return EfficiencyStatsBloc(refuelingsBloc: refuelingsBloc);
      },
      act: (bloc) async {
        bloc.add(LoadEfficiencyStats());
        bloc.add(UpdateEfficiencyData([refueling, 
        refueling.copyWith(date: DateTime.fromMillisecondsSinceEpoch(100), efficiency: 2.0)]));
      },
      expect: [
        EfficiencyStatsLoading(),
        EfficiencyStatsLoaded([]), // no graph with only one point
        EfficiencyStatsLoaded([
          Series<FuelMileagePoint, DateTime>(
            id: 'Fuel Mileage vs Time', 
            domainFn: (point, _) => point.date,
            measureFn: (point, _) => point.efficiency,
            data: [FuelMileagePoint(refueling.date, refueling.efficiency),
            FuelMileagePoint(DateTime.fromMillisecondsSinceEpoch(100), 2.0)],
          ),
          Series<FuelMileagePoint, DateTime>(
            id: 'EMA', 
            domainFn: (point, _) => point.date,
            measureFn: (point, _) => point.efficiency,
            data: [FuelMileagePoint(refueling.date, refueling.efficiency),
            FuelMileagePoint(DateTime.fromMillisecondsSinceEpoch(100), EfficiencyStatsBloc.emaFilter(1.0, 2.0))],
          )
        ])
      ]
    );
  });
}