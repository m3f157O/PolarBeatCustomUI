import 'dart:async';
import 'dart:convert';

import 'package:custom_polar_beat_ui_v2/controller/net_controller.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/extension.dart';

//TODO FATAL MAKE DB CHECK WETHER TABLES EXIST DURING INIT
//TODO SYNCHRONIZE PROPERLY


class DataBase {

    static late final Database _database;
    static const _databaseName = "/my_db";
    final NetController net=NetController();


    Future<bool> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath+_databaseName;
    _database = await openDatabase(path);
    var result =await _database.rawQuery("SELECT * FROM sqlite_master WHERE name='Tokens'");
    if(result.isEmpty) {

      print("Crash Saved");
      createTokenTable();
      result =await _database.rawQuery("SELECT * FROM sqlite_master WHERE name='Exercises'");
      if(result.isEmpty) {
        createExercisesTable();
      }
      result =await _database.rawQuery("SELECT * FROM sqlite_master WHERE name='Profile'");
      if(result.isEmpty) {
        createProfileTable();
      }
    }



    return true;
  }


    void updateTokenTable(String type,String token) async {
      Map<String,String> map={ "type":type,"name":token };
      await _database.insert("Tokens",map);
      print(type+" stored");
    }


    void updateProfileTable(Map<String,Object> toPass) async {

      var transformedMap = toPass.map((k, v) {return MapEntry(k.replaceAll("-", ""), v);});

      await _database.insert("Profile",transformedMap);
      print("Profile stored");
    }

    void updateExercisesTable(Map<String,Object> toPass) async {
      await _database.insert("Exercises",toPass);
      var result = await _database.query("Exercises");
      print(result);
      print("Exercises stored");
    }

    void dropTokenTable() async {
      _database.execute('DROP TABLE Tokens');
    }

    void dropExercisesTable() async {
      _database.execute('DROP TABLE Exercises');
    }

    void dropProfileTable() async {
      _database.execute('DROP TABLE Profile');
    }

     Future<bool> reset() async {

       synchronized(() async {
         dropTokenTable();
       });
       synchronized(() async {
         createTokenTable();
       });
       synchronized(() async {
         dropProfileTable();
       });
       synchronized(() async {
         createProfileTable();
       });
       synchronized(() async {
         dropExercisesTable();
       });
       synchronized(() async {
         createExercisesTable();
       });

      return true;

    }



    void createTokenTable() async {
      _database.execute(
          'CREATE TABLE Tokens (type TEXT, name TEXT)');
    }

    void createProfileTable() async {
      _database.execute(
          'CREATE TABLE Profile (polaruserid TEXT, registrationdate TEXT, firstname TEXT, lastname TEXT, birthdate TEXT, gender TEXT)');
    }


    void createExercisesTable() async {
      _database.execute(
          'CREATE TABLE Exercises (id INT, uploadtime TEXT, polaruser TEXT, transactionid TEXT, device TEXT, starttime TEXT, starttimeutcoffset INT, duration TEXT, calories INT, distance INT, maximum INT ,average INT, sport TEXT, hasroute TEXT, detailedsportinfo TEXT)');
    }

     Future<String> fetchFromTokenTable(String type) async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='$type'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }

    Future<Map<dynamic,dynamic>> fetchProfile() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Profile");

      if(list.isEmpty) {
        return {};
      } else {

        return list.elementAt(0);
      }
    }






    Future<bool> fetchAccessToken() async {

      print("Fetching token");

      String temp= await fetchFromTokenTable('bearer');
      String temp2= await fetchFromTokenTable('id');
      String code=await fetchFromTokenTable('code');

      if(temp2.isNotEmpty) {
        net.setToken(temp);
        net.setId(temp2);
        print("Loading saved token");
        return true;
      }

      String response = await NetController().fireTokenDataRequest(code);


      String id=response.split('B')[0];
      String token='B'+response.split('B')[1];

      updateTokenTable("bearer",token);
      updateTokenTable("id",id);
      return false;
    }

    Future<bool> registerUser() async {



      String token=await fetchFromTokenTable('bearer');
      String id=await fetchFromTokenTable('id');

      return await NetController().registerUser(token, id);

    }


    Future<Map<String,Object>> fireUserInfoRequest() async {



      String token= await fetchFromTokenTable('bearer');
      String userId=await fetchFromTokenTable('id');
      var temp=await fetchProfile();
      if(temp.isNotEmpty) {
        print("Loading Profile from sqflite");
        return Map.from(temp);
      }

      Map<String,Object> response = await NetController().userProfileRequest(token, userId);
      updateProfileTable(response);
      return response;

    }



    Future<List<Map<String,Object>>> fetchActivities() async {

      String token= await fetchFromTokenTable('bearer');

      print("Authenticating for notifications");
      List<Map<String,Object>> response = await NetController().exerciseCoordinator(token);
      for(int i=0;i<response.length;i++) {
        updateExercisesTable(response.elementAt(i));
      }
      return response;

    }




  Future<List<Map<dynamic, dynamic>>> fetchSavedActivities() async {

    List<Map> list = await _database.rawQuery("SELECT * FROM Exercises");

    if(list.isEmpty) {
      return [];
    } else {


      List<Map<String,Object>> temp= [];


      return list;
    }
    }



}