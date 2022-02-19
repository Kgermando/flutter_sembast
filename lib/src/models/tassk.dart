import 'package:sembast/sembast.dart';

class Task {
  int? key;
  bool done;
  String name;

  Task({this.key, required this.name, this.done = false});

  Task.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        done = json['done'] as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'done': done,
      };

  Task.fromDatabase(RecordSnapshot<int, Map<String, dynamic>> snapshot)
      : name = snapshot.value['name'] as String,
        done = snapshot.value['done'] as bool,
        key = snapshot.key;

  @override
  String toString() {
    return "Task { KEY: $key, NAME: $name, DONE: $done }";
  }
}
