import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:autodo/blocs/blocs.dart';

import 'screen.dart';

/// Structures the BlocProviders for the homescreen and exports them for
/// use by the main screen.
class HomeScreenProvider extends StatelessWidget {
  final bool integrationTest;

  HomeScreenProvider({this.integrationTest});

  @override
  build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<TabBloc>(
            create: (context) => TabBloc(),
          ),
          BlocProvider<FilteredTodosBloc>(
            create: (context) => FilteredTodosBloc(
              todosBloc: BlocProvider.of<TodosBloc>(context),
            ),
          ),
          BlocProvider<FilteredRefuelingsBloc>(
            create: (context) => FilteredRefuelingsBloc(
                carsBloc: BlocProvider.of<CarsBloc>(context),
                refuelingsBloc: BlocProvider.of<RefuelingsBloc>(context)),
          ),
        ],
        child: HomeScreen(integrationTest: integrationTest),
      );
}
