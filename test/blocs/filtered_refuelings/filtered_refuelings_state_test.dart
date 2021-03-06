import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:autodo/blocs/blocs.dart';
import 'package:autodo/models/models.dart';

class MockRefuelingsBloc extends MockBloc<RefuelingsEvent, RefuelingsState>
    implements RefuelingsBloc {}

void main() {
  group('FilteredRefuelingsState', () {
    final refueling = Refueling(
        carName: '',
        id: '',
        mileage: 0,
        date: DateTime.fromMillisecondsSinceEpoch(0),
        amount: 0,
        cost: 0,
        carColor: Color(0),
        efficiency: 0.0,
        efficiencyColor: Color(0));
    test('props are correct', () {
      expect(
        FilteredRefuelingsLoading().props,
        [],
      );
    });
    group('FilteredRefuelingsLoaded', () {
      test('toString returns correct value', () {
        expect(
          FilteredRefuelingsLoaded(
              [refueling], VisibilityFilter.active, [Car()]).toString(),
          'FilteredRefuelingsLoaded { filteredRefuelings: [$refueling], activeFilter: VisibilityFilter.active, cars: ${[
            Car()
          ]} }',
        );
      });
      test('props are correct', () {
        expect(
          FilteredRefuelingsLoaded(
              [refueling], VisibilityFilter.active, [Car()]).props,
          [
            [refueling],
            VisibilityFilter.active,
            [Car()]
          ],
        );
      });
    });
  });
}
