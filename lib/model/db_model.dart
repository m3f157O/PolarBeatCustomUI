import 'package:sqflite/sqflite.dart';

//TODO FATAL MAKE DB CHECK WETHER TABLES EXIST DURING INIT



class DataBase {

    static late final Database _database;

    static const _databaseName = "/my_db";


  static void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath+_databaseName;
    print(path);
    _database = await openDatabase(path) ;
  }
   static Future<Database> get database async {
    return _database;
    }


    static void updateTokenTable(String type,String token) async {
      Map<String,String> map={ "type":type,"name":token };
      // List<Map> result = await db.query("Tokens");

      await _database.insert("Tokens",map);
      var result = await _database.query("Tokens");
      print(result);
      print("database after "+type+" storage");
    }



    static void dropTable() async {

      await _database.execute('DROP TABLE Tokens');


    }

    static void reset() async {

      dropTable();
      createTable();

    }

    static void createTable() async {


           await _database.execute(
             'CREATE TABLE Tokens (type TEXT, name TEXT)');

    }


    /// HARDCODING HERE IS NECESSARY BECAUSE
    /// I DON'T WANT TO USE SQL HELPERS
    static Future<String> fetchToken() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='bearer'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }


    static Future<String> fetchId() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='id'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }

    static Future<String> fetchCode() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='code'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }


}