import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:autodo/blocs/blocs.dart';
import 'package:autodo/models/models.dart';
import 'package:autodo/localization.dart';

class ExtraActions extends StatelessWidget {
  final Key toggleAllKey;

  ExtraActions(
      {Key key = const ValueKey('__extra_actions__'), this.toggleAllKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTodosBloc, FilteredTodosState>(
      builder: (context, state) {
        if (state is FilteredTodosLoaded) {
          bool allComplete =
              (BlocProvider.of<TodosBloc>(context).state as TodosLoaded)
                  .todos
                  .every((todo) => todo.completed);
          final filterState = (BlocProvider.of<FilteredTodosBloc>(context).state
                  as FilteredTodosLoaded)
              .activeFilter;
          return PopupMenuButton<ExtraAction>(
            onSelected: (action) {
              switch (action) {
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<TodosBloc>(context).add(ToggleAll());
                  break;
                case ExtraAction.toggleFilter:
                  var nextFilter = (filterState == VisibilityFilter.all)
                      ? VisibilityFilter.active
                      : VisibilityFilter.all;
                  BlocProvider.of<FilteredTodosBloc>(context)
                      .add(UpdateTodosFilter(nextFilter));
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: toggleAllKey,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? AutodoLocalizations.markAllIncomplete
                      : AutodoLocalizations.markAllComplete,
                ),
              ),
              PopupMenuItem<ExtraAction>(
                key: ValueKey('__filter_button__'),
                value: ExtraAction.toggleFilter,
                child: Text((filterState == VisibilityFilter.all)
                    ? 'Only Show Active ToDos'
                    : 'Show All ToDos'),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
