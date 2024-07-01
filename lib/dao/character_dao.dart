import 'package:rick_morty_app/database/app_database.dart';
import 'package:rick_morty_app/models/character.dart';
import 'package:sqflite/sqflite.dart';

class CharacterDao {
  insert(Character character) async {
    Database database = await AppDatabase().openDB();
    await database.insert(AppDatabase().tableName, character.toMap());
  }

  delete(Character character) async {
    Database database = await AppDatabase().openDB();
    await database.delete(AppDatabase().tableName,
        where: "id = ?", whereArgs: [character.id]);
  }

  deleteById(String id) async {
    Database database = await AppDatabase().openDB();
    await database.delete(AppDatabase().tableName,
        where: "id = ?", whereArgs: [id]);
  }

  Future<List> fetchAll() async {
    Database database = await AppDatabase().openDB();
    List maps = await database.query(AppDatabase().tableName);
    return maps.map((map) => FavoriteCharacter.fromMap(map)).toList();
  }

  Future<bool> isFavorite(Character character) async {
    Database database = await AppDatabase().openDB();
    List maps = await database.query(AppDatabase().tableName,
        where: "id = ?", whereArgs: [character.id]);
    return maps.isNotEmpty;
  }
}
