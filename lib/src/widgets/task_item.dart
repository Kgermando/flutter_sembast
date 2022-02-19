import 'package:fkutter_sembast/src/global/task_store/task_store.dart';
import 'package:fkutter_sembast/src/models/tassk.dart';
import 'package:fkutter_sembast/src/widgets/task_delete.dart';
import 'package:flutter/material.dart';


class TaskItem extends StatefulWidget {
  final Task task;
  final TaskStore taskStore = TaskStore();

  TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  
  TextStyle _getTaskStyle() {
    return TextStyle(
        decoration: widget.task.done
            ? TextDecoration.lineThrough
            : TextDecoration.none);
  }

  _onChangeHandler(bool newValue) {
    setState(() {
      widget.task.done = newValue;
      widget.taskStore.update(widget.task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TaskDelete(
      task: widget.task,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: CheckboxListTile(
          value: widget.task.done,
          onChanged: (bool) {},
          title: Text(
            widget.task.name,
            style: _getTaskStyle(),
          ),
        ),
      ),
    );
  }
}
