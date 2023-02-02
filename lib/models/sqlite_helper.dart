import 'package:tdvp/models/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String databaseName = 'tdvp.db';
  final int version = 1;
  final String databaseTable = 'productTable';

  final String columnId = 'id';
  final String columnNameProduct = 'productname';
  final String columnPrice = 'price';
  final String columnAmount = 'quantity';
  final String columnSum = 'sum';
  final String columnDocProduct = 'docProduct';
  final String columnDocStock = 'docStock';
  final String columnDocUser = 'docUser';

  SQLiteHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $databaseTable (id INTEGER PRIMARY KEY, $columnNameProduct TEXT, $columnPrice TEXT, $columnAmount TEXT, $columnSum TEXT, $columnDocProduct TEXT, $columnDocStock TEXT, $columnDocUser TEXT)'),
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return openDatabase(join(await getDatabasesPath(), databaseName));
  }

  Future<void> insertValueToSQLite(SQLiteModel sqLiteModel) async {
    Database database = await connectedDatabase();
    database.insert(
      databaseTable,
      sqLiteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SQLiteModel>> readAllData() async {
    Database database = await connectedDatabase();
    var sqliteModels = <SQLiteModel>[];
    var maps = await database.query(databaseTable);
    for (var item in maps) {
      SQLiteModel sqLiteModel = SQLiteModel.fromMap(item);
      sqliteModels.add(sqLiteModel);
    }
    return sqliteModels;
  }

  Future<void> deleteValueFromId(int id) async {
    Database database = await connectedDatabase();
    await database.delete(databaseTable, where: '$columnId = $id');
  }

  Future<void> deleteAllData() async {
    Database database = await connectedDatabase();
    await database.delete(databaseTable);
  }
}
