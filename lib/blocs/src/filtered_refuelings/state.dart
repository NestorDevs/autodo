import 'package:equatable/equatable.dart';
import 'package:autodo/models/models.dart';

abstract class FilteredRefuelingsState extends Equatable {
  const FilteredRefuelingsState();

  @override
  List<Object> get props => [];
}

class FilteredRefuelingsNotLoaded extends FilteredRefuelingsState {}

class FilteredRefuelingsLoading extends FilteredRefuelingsState {}

class FilteredRefuelingsLoaded extends FilteredRefuelingsState {
  final List<Refueling> filteredRefuelings;
  final List<Car> cars;
  final VisibilityFilter activeFilter;

  const FilteredRefuelingsLoaded(
      this.filteredRefuelings, this.activeFilter, this.cars);

  @override
  List<Object> get props => [filteredRefuelings, activeFilter, cars];

  @override
  String toString() {
    return 'FilteredRefuelingsLoaded { filteredRefuelings: $filteredRefuelings, activeFilter: $activeFilter, cars: $cars }';
  }
}
