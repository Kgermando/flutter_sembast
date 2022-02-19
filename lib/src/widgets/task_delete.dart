import 'package:fkutter_sembast/src/global/task_store/task_store.dart';
import 'package:fkutter_sembast/src/models/tassk.dart';
import 'package:flutter/material.dart';


class TaskDelete extends StatelessWidget {
  final TaskStore taskStore = TaskStore();
  final Widget child;
  final Task task;

  TaskDelete({required this.task, required this.child});

  Widget _getBackground() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 16),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Future<bool> _confirmDismissHandler(
      BuildContext context, DismissDirection direction) async {
    final bool answer = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Do You Really Want to remove this task?"),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Cancel",
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text(
                "Delete",
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    return answer;
  }

  _onDismissedHandler(DismissDirection direction) {
    taskStore.delete(task);
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return _confirmDismissHandler(context, direction);
      },
      direction: DismissDirection.endToStart,
      onDismissed: _onDismissedHandler,
      background: _getBackground(),
      key: Key(task.key.toString()),
      child: child,
    );
  }
}
