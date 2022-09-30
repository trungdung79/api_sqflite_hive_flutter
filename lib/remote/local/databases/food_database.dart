import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../models/food_model.dart';

class FoodDatabase {

  final String DB_NAME = "food.db";
  final String TABLE = "food";
  final String ID = "id";
  final String TITLE = "title";
  final String THUMBNAIL = "thumbnail";
  final String DESCRIPTION = "decscription";

  static final FoodDatabase _instance = FoodDatabase._();
  FoodDatabase._();

  factory FoodDatabase() {
    return _instance;
  }

  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await init();
    return _database;
  }

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);

    var database = openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $TABLE(
        $ID INTEGER PRIMARY KEY AUTOINCREMENT,
        $TITLE TEXT,
        $THUMBNAIL TEXT,
        $DESCRIPTION TEXT)
    ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  // CRUD: Create, Read, Update, Delete
  Future<int> addFoodModel(FoodModel? foodModel) async {
    var client = await db;
    return client!.insert(TABLE, foodModel!.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<FoodModel?> fetchInformation(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
    client!.query(TABLE, where: '$ID = ?', whereArgs: [id]);
    var maps = await futureMaps;
    if (maps.length != 0) {
      return FoodModel.fromJson(maps.first);
    }
    return null;
  }

  Future<List<FoodModel>> fetchAll() async {
    var client = await db;
    var res = await client!.query(TABLE);

    if (res.isNotEmpty) {
      var foodList = res.map((foodModelMap) => FoodModel.fromJson(foodModelMap)).toList();
      return foodList;
    }
    return [];
  }

  Future<int> updateFoodModel(FoodModel newFoodModel) async {
    var client = await db;
    return client!.update(TABLE, newFoodModel.toJson(),
        where: '$ID = ?', whereArgs: [newFoodModel.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future closeDb() async {
    var client = await db;
    client!.close();
  }
}