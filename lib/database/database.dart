import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    // getter to open a connection to database
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
    await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String db =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,contact Text,description TEXT);";
    await database.execute(db);
  }
}