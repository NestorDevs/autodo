import 'package:flutter/material.dart';
import 'package:autodo/state.dart';
import 'package:autodo/items/items.dart';
import 'package:autodo/screens/screens.dart';

class AutodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AutodoAppState();
  }
}

class AutodoAppState extends State<AutodoApp> {
  static AutodoState autodoState;
  static bool userExists = false;

  @override
  void initState() {
    super.initState();

    autodoState = AutodoState();

    // Eventually put the code for loading an old session's data
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'auToDo',
      initialRoute: userExists ? '/' : '/welcomescroll',
      routes: {
        '/': (context) => HomeScreen(
              autodoState: autodoState,
              addMaintenanceTodo: addMaintenanceTodo,
            ),
        '/welcomescroll': (context) => LoginPage(), // Was WelcomePage()
        '/createTodo': (context) =>
            // CreateTodoScreen(addMaintenanceTodo: addMaintenanceTodo),
            CreateTodoScreen(),
        '/createRefueling': (context) => CreateRefuelingScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }

  void addMaintenanceTodo(MaintenanceTodoItem todo) {
    setState(() {
      autodoState.todos.add(todo);
    });
  }

  void removeMaintenanceTodo(MaintenanceTodoItem todo) {
    setState(() {
      autodoState.todos.remove(todo);
    });
  }

  void updateMaintenanceTodo(MaintenanceTodoItem todo,
      {String name, DateTime dueDate, int dueMileage}) {
    setState(() {
      todo.name = name ?? todo.name;
      todo.dueDate = dueDate ?? todo.dueDate;
      todo.dueMileage = dueMileage ?? todo.dueMileage;
    });
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);

    // save todos to repo
  }
}
