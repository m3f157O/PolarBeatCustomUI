import 'dart:async';

import 'package:custom_polar_beat_ui_v2/controller/net_controller.dart';
import 'package:custom_polar_beat_ui_v2/view/graphs/fast_iso.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/extension.dart';

import 'model.dart';

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
    //this is to create tables on first start
    if(result.isEmpty) {

      print("First start");
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


    void updateTokenTable(String type,String token,String expiredate) async {
      Map<String,String> map={ "type":type,"name":token, "expiredate":expiredate };
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
          'CREATE TABLE Tokens (type TEXT, name TEXT, expiredate TEXT)');
    }

    void createProfileTable() async {
      _database.execute(
          'CREATE TABLE Profile (polaruserid TEXT, registrationdate TEXT, firstname TEXT, lastname TEXT, birthdate TEXT, gender TEXT)');
    }

    void createExercisesTable() async {
      _database.execute(
          'CREATE TABLE Exercises (id INT, uploadtime TEXT, polaruser TEXT, transactionid TEXT, device TEXT, starttime TEXT, starttimeutcoffset INT, duration TEXT, calories INT, distance INT, maximum INT ,average INT, sport TEXT, hasroute INT, detailedsportinfo TEXT, zones TEXT, samples TEXT, gpx TEXT)');
    }

    Future<String> fetchFromTokenTable(String type) async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='$type'");

      if(list.isEmpty) {
        return "";
      } else {

        print(DateTime.parse(list.elementAt(0)["expiredate"]));
        return list.elementAt(0)["name"];
      }
    }

    Future<String> fetchFromTokenTableDate() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='bearer'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["expiredate"];
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

      updateTokenTable("bearer",token,(DateTime.now().add(const Duration(days: 10))).toString());
      updateTokenTable("id",id,DateTime.now().toString());
      return false;
    }

    Future<bool> registerUser() async {



      String token=await fetchFromTokenTable('bearer');
      String id=await fetchFromTokenTable('id');

      return await NetController().registerUser(token, id);

    }


    Future<bool> fireUserInfoRequest(BuildContext context) async {


      //if not present, the POLAR APIs are called
      Map<String,Object> response;
      String token= await fetchFromTokenTable('bearer');
      String userId=await fetchFromTokenTable('id');
      var temp=await fetchProfile();
      if(temp.isNotEmpty) {
        print("Loading Profile from sqflite");
        Provider.of<AppState>(context,listen: false).setProfile(temp);
        return true;
      }
      else
      {
        response = await NetController().userProfileRequest(token, userId);
        updateProfileTable(response);
        Provider.of<AppState>(context,listen: false).setProfile(response);
        return false;

      }

    }



    Future<bool> fetchActivities(BuildContext context) async {

      //if not present, the POLAR APIs are called

      String token= await fetchFromTokenTable('bearer');
      print("Authenticating for notifications");
      List<Map<String,Object>> response = await NetController().exerciseCoordinator(token);
      for(int i=0;i<response.length;i++) {
        updateExercisesTable(response.elementAt(i));
        print("Updating exercises table");

      }
      Provider.of<AppState>(context,listen: false).setNewActivities(response);

      //TODO FIX THIS: AFTER NEW ACTIVITIES ARE SHOWN DB IS UPDATED, WHEN USER REFRESHES THEY ARE CLEARED FROM NEW
      return true;

    }


    Future<bool> editActivities(Map<dynamic,dynamic> toEdit, dynamic field, dynamic value) async {


      //this is necessary for db compatibility


      Map<String,Object> toAdd=Map.from(toEdit);
      toAdd[field]=value;
      await _database.update(
        "Exercises",
        toAdd,
        where: "starttime = ?",
        whereArgs: [toAdd["starttime"]],
      );
      return true;

    }




    Future<bool> fetchSavedActivities(BuildContext context) async {

      //if not present, the POLAR APIs are called

      List<Map> list = await _database.rawQuery("SELECT * FROM Exercises");

    if(list.isEmpty) {
      return false;
    } else {


      print("Loading saved activites from db");
      Provider.of<AppState>(context,listen: false).setActivities(list);
      Provider.of<AppState>(context,listen: false).clearNewBuffer();

      Map<String,Object> temp=Map.from(list.elementAt(0));

      print(temp);
      return true;
    }
  }



    Future<bool> fetchActivitiesBy(BuildContext context,String toOrder) async {


      List<Map> list = await _database.query('Exercises', orderBy: toOrder);

      if(list.isEmpty) {
        return false;
      } else {



        Provider.of<AppState>(context,listen: false).setActivities(list);

        return true;
      }


    }

    Future<bool> setTotalCalories(BuildContext context) async {


      List<Map> list = await _database.rawQuery(
          'select sum(calories) as C from Exercises');
      if(list.elementAt(0)["C"]=="null") {
        Provider.of<AppState>(context,listen: false).setCalories(0);
        return false;
      } else {
        print(list);
        print("CALORIEEEEEEEEEEEEEEEEEEEEEEEEEEE");
        Provider.of<AppState>(context,listen: false).setCalories(list.elementAt(0)["C"]);

        return true;
      }


    }

    Future<bool> setTotalDistance(BuildContext context) async {


      List<Map> list = await _database.rawQuery(
          'select sum(distance) as C from Exercises');
      if(list.elementAt(0)["C"]=="null") {
        Provider.of<AppState>(context,listen: false).setDistance(0);

        return false;
      } else {

        Provider.of<AppState>(context,listen: false).setDistance(list.elementAt(0)["C"]);

        return true;
      }


    }

    Future<bool> setTotalTime(BuildContext context) async {


      List<Map> list = await _database.rawQuery(
          'select duration C from Exercises');
      if(list.elementAt(0)["C"]=="null") {
        Provider.of<AppState>(context,listen: false).setTime(Duration.zero);
        return false;
      } else {

        Duration duration=Duration.zero;
        for(int i=0;i<list.length;i++) {
          duration=duration+toDuration(list.elementAt(i)["C"]);
        }

        Provider.of<AppState>(context,listen: false).setTime(duration);

        return true;
      }




    }

    bool compareDateTime(DateTime one,DateTime two) {
      return one.day==two.day&&one.month==two.month&&one.year==two.year;
    }
    Future<bool> setTodayCalories(BuildContext context) async {


      List<Map> list = await _database.rawQuery(
          'select calories,uploadtime from Exercises');
      if(list.isEmpty) {
        return false;
      } else {

        num total=0;

        for(int i=0;i<list.length;i++) {
          if(compareDateTime(DateTime.parse(list.elementAt(i)["uploadtime"]),DateTime.now())) {
            total= total+list.elementAt(i)["calories"];
          }
        }
        Provider.of<AppState>(context,listen: false).setLocalCalories(total.toInt());


        return true;
      }




    }

    Future<bool> setTodayDistance(BuildContext context) async {


      List<Map> list = await _database.rawQuery(
          'select distance,uploadtime from Exercises');
      if(list.isEmpty) {
        return false;
      } else {

        num total=0;
        for(int i=0;i<list.length;i++) {
          if(compareDateTime(DateTime.parse(list.elementAt(i)["uploadtime"]),DateTime.now())) {
            total= total+list.elementAt(i)["distance"];
          }
          print("TOTAL DISTANCE IS "+ total.toString());
        }
        Provider.of<AppState>(context,listen: false).setLocalDistance(total.toInt());


        return true;
      }




    }


    Future<bool> setTops(BuildContext context) async {


      List<Map> list = List.from(await _database.query('Exercises', orderBy: "distance",));
      list=List.from(list.reversed);
      list=list.sublist(0,3);
      Provider.of<AppState>(context,listen: false).setDistanceActivities(list);

      list = List.from(await _database.query('Exercises', orderBy: "duration",));
      list=List.from(list.reversed);
      list=list.sublist(0,3);

      Provider.of<AppState>(context,listen: false).setDurationActivities(list);

      list = List.from(await _database.query('Exercises', orderBy: "calories",));
      list=List.from(list.reversed);
      list=list.sublist(0,3);
      Provider.of<AppState>(context,listen: false).setCaloriesActivities(list);

      return true;




    }

    Future<bool> fetchTopBy(BuildContext context) async {


      List<Map> list = await _database.rawQuery(
          'select distance,uploadtime from Exercises');
      if(list.isEmpty) {
        return false;
      } else {

        num total=0;
        for(int i=0;i<list.length;i++) {
          if(compareDateTime(DateTime.parse(list.elementAt(i)["uploadtime"]),DateTime.now())) {
            total= total+list.elementAt(i)["distance"];
          }
          print("TOTAL DISTANCE IS "+ total.toString());
        }
        Provider.of<AppState>(context,listen: false).setLocalDistance(total.toInt());


        return true;
      }




    }



}