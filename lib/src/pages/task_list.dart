import 'package:fkutter_sembast/src/global/task_store/task_store.dart';
import 'package:fkutter_sembast/src/models/tassk.dart';
import 'package:fkutter_sembast/src/widgets/task_add.dart';
import 'package:fkutter_sembast/src/widgets/task_item.dart';
import 'package:fkutter_sembast/src/widgets/task_update.dart';
import 'package:flutter/material.dart';


class TaskListScreen extends StatelessWidget {
  final TaskStore taskStore = TaskStore();

  TaskListScreen({Key? key}) : super(key: key);

  _onPressedHandler(BuildContext context) async {
    Task 
    task = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: TaskAdd(),
        );
      },
    );
    if (task != null) {
      taskStore.save(task);
    }
  }

  _onLongPressHandler(BuildContext context, Task task) async {
    Task taskEdited = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: TaskUpdate(task: task),
        );
      },
    );
    if (taskEdited != null) {
      taskStore.update(taskEdited);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedHandler(context),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: taskStore.stream(),
          builder: (context, AsyncSnapshot<Stream<List<Task>>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Stream<List<Task>>? _stream = snapshot.data;
              return StreamBuilder<List<Task>>(
                stream: _stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    List<Task>? _taskList = snapshot.data;
                    if (_taskList!.isEmpty) {
                      TextTheme textTheme = Theme.of(context).textTheme;
                      return Center(
                        child: Text(
                          "Nothing To do",
                          style: textTheme.headline6,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: _taskList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onLongPress: () =>
                                _onLongPressHandler(context, _taskList[index]),
                            child: TaskItem(task: _taskList[index]),
                          );
                        },
                      );
                    }
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
