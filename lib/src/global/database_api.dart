import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class DatabaseApi {
  static const String databaseName = "tasks.db";
  static final DatabaseApi _singleton = DatabaseApi._();

  static DatabaseApi get instance => _singleton;
  Completer<Database>? _dbOpenCompleter;
  DatabaseApi._();

  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }
    return _dbOpenCompleter!.future;
  }

  Future _openDatabase() async {
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, databaseName);

    final database = await databaseFactoryIo.openDatabase(dbPath);
    _dbOpenCompleter!.complete(database);
  }

  
}