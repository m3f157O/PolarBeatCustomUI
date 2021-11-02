import 'package:sqflite/sqflite.dart';

//TODO FATAL MAKE DB CHECK WETHER TABLES EXIST DURING INIT



class DataBase {

    static late final Database _database;

    static const _databaseName = "/my_db";


    Future<bool> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath+_databaseName;
    print(path);
    _database = await openDatabase(path);
    return true;
  }
    Future<Database> get database async {
    return _database;
    }


     void updateTokenTable(String type,String token) async {
      Map<String,String> map={ "type":type,"name":token };
      // List<Map> result = await db.query("Tokens");

      await _database.insert("Tokens",map);
      var result = await _database.query("Tokens");
      print(result);
      print("database after "+type+" storage");
    }


    void updateProfileTable(Map<String,Object> map) async {
      // List<Map> result = await db.query("Tokens");

      await _database.insert("Profile",map);
      var result = await _database.query("Tokens");
      print(result);
      print("database after storage");
    }

     void dropTable() async {

      await _database.execute('DROP TABLE Tokens');


    }

     void reset() async {

      dropTable();
      createTable();

    }

    void createTable() async {


      await _database.execute(
          'CREATE TABLE Tokens (type TEXT, name TEXT)');

    }

    void createProfileTable() async {


      await _database.execute(
          'CREATE TABLE Profile (polaruserid INT, recdate TEXT, firstname TEXT, lastname TEXT, birthdate TEXT, gender TEXT)');

    }


    /// HARDCODING HERE IS NECESSARY BECAUSE
    /// I DON'T WANT TO USE SQL HELPERS
     Future<String> fetchToken() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='bearer'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }


     Future<String> fetchId() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='id'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }

     Future<String> fetchCode() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='code'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }


}