import 'package:flutter/material.dart';
import 'package:autodo/models/models.dart';

class DeleteTodoSnackBar extends SnackBar {
  DeleteTodoSnackBar({
    Key key,
    @required Todo todo,
    @required VoidCallback onUndo,
    @required BuildContext context
  }) : super(
          key: key,
          content: Text(
            AutodoLocalization.of(context).todoDeleted(todo.name),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: AutodoLocalization.of(context).undo,
            onPressed: onUndo,
          ),
        );
}

class DeleteRefuelingSnackBar extends SnackBar {
  DeleteRefuelingSnackBar({
    Key key,
    @required VoidCallback onUndo,
    @required BuildContext context
  }) : super(
          key: key,
          content: Text(
            AutodoLocalization.of(context).refuelingDeleted,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: AutodoLocalization.of(context).undo,
            onPressed: onUndo,
          ),
        );
}

class DeleteRepeatSnackBar extends SnackBar {
  DeleteRepeatSnackBar({
    Key key,
    @required VoidCallback onUndo,
    @required BuildContext context
  }) : super(
          key: key,
          content: Text(
            AutodoLocalization.of(context).repeatDeleted,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: AutodoLocalization.of(context).undo,
            onPressed: onUndo,
          ),
        );
}
