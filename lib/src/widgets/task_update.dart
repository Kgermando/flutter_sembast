import 'package:fkutter_sembast/src/models/tassk.dart';
import 'package:flutter/material.dart';


class TaskUpdate extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final Task task;

  TaskUpdate({Key? key, required this.task}) : super(key: key) {
    _controller.text = task.name;
  }

  _onSubmittedHandler(BuildContext context) {
    String value = _controller.text.trim();
    if (value == task.name) {
      Navigator.of(context).pop();
    } else {
      task.name = value;
      Navigator.of(context).pop(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: true,
      autofocus: true,
      enableSuggestions: true,
      textCapitalization: TextCapitalization.sentences,
      controller: _controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.send,
      onSubmitted: (_) => _onSubmittedHandler(context),
      decoration: const InputDecoration(
          labelText: "Task", prefixIcon: Icon(Icons.assignment)),
    );
  }
}
