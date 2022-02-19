import 'dart:async';

import 'package:fkutter_sembast/src/global/database_api.dart';
import 'package:fkutter_sembast/src/models/tassk.dart';
import 'package:sembast/sembast.dart';


class TaskStore  {
  static const String storeName = "task";

  final _store = intMapStoreFactory.store(storeName);
  Future<Database> get _db async => await DatabaseApi.instance.database;

  save(Task entity) async {
    await _store.add(await _db, entity.toJson());
  }

  update(Task entity) async {
    final finder = Finder(filter: Filter.byKey(entity.key));
    await _store.update(await _db, entity.toJson(), finder: finder);
  }

  delete(Task entity) async {
    final finder = Finder(filter: Filter.byKey(entity.key));
    await _store.delete(await _db, finder: finder);
  }

  Future<Stream<List<Task>>> stream() async {
    // debugPrint("Geting Data Stream");
    var streamTransformer = StreamTransformer<
        List<RecordSnapshot<int, Map<String, dynamic>>>,
        List<Task>>.fromHandlers(
      handleData: _streamTransformerHandlerData,
    );

    return _store.query().onSnapshots(await _db).transform(streamTransformer);
  }


  Future<List<Task>> findAll() async {
    final snapshot = await _store.find(await _db);
    return snapshot.map((e) => Task.fromDatabase(e)).toList();
  }

  _streamTransformerHandlerData(
      List<RecordSnapshot<int, Map<String, dynamic>>> snapshotList,
      EventSink<List<Task>> sink) {
    List<Task> resultSet = [];
    for (var element in snapshotList) {
      resultSet.add(Task.fromDatabase(element));
    }
    sink.add(resultSet);
  }

}