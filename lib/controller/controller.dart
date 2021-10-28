
import 'package:custom_polar_beat_ui_v2/model/db_model.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/deserialization.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';
import 'package:sqflite/sqflite.dart';

/// -----------------------------------
///           CONTROLLER
/// -----------------------------------
///       HOW TO ADD A NEW VIEW LINK:
/// 1. CREATE NEW VIEW
/// 2. CREATE AN ENUM INSTANCE, AND THE CORRESPONDING MODEL SETTER (VIA CONTROLLER) DOWN HERE
/// 3. CALL THE CORRESPONDING MODEL SETTER IN THE VIEW THAT YOU WANT TO BE ***BEFORE*** YOUR NEW VIEW
/// 4. ADD THE KEY-VALUE PAIR AS <PHASE:NEW_VIEW> (THAT'S THE """"STATE MACHINE"""") IN THE IDENTIFIER MAP IN main.dart
/// 5. NOW WHEN CONDITIONS ARE MET, THE NEW ENUM INSTANCE WILL BE THE AppState.state AND THE MODEL WILL MAKE THE VIEW TRANSITION
///
const polarClientId = '21e2f720-3832-42d4-b8ad-3d8ef0067023';

class Controller {
  // Models
  static final Controller _instance = Controller();

  static getController(){
  return _instance;
}
  void toDebugAuthCode(BuildContext context,String code) {
    DataBase.updateTokenTable("code", code);
    Provider.of<AppData>(context, listen: false).setCode(code);
    Provider.of<AppState>(context,listen: false).setstate(PHASE.getTokenFromPolar);

  }


  static void fetchDb() async {
    DataBase.initDatabase();

  }

  static Future<String> fetchToken() async {
    return await DataBase.fetchToken();
  }
  static Future<String> fetchTokenOnStart() async {
    await Future.delayed(const Duration(seconds: 1));
    return await DataBase.fetchToken();
  }
  static Future<String> fetchCode() async {
    return await DataBase.fetchCode();
  }
  static void updateToken(String token) async {
    DataBase.updateTokenTable("bearer", token);
  }


  static void reset() async {
    DataBase.reset();
  }

  static Future<String> fetchId() async {
    return await DataBase.fetchId();
  }

  static void updateId(String id) async {
    DataBase.updateTokenTable("id", id);
  }



  static Future<Database> fetchDbAsync() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath+"/my_db";
    return await openDatabase(path) ;
  }

  void toGetTokenFromPolar(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.getTokenFromPolar);

  }
  void toViewMenu(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.viewMenu);

  }

  static void addAppData(BuildContext context, Available data) {
    Provider.of<AppData>(context,listen: false).addData(data);
    Provider.of<AppState>(context,listen: false).setstate(PHASE.showData);

  }
  static void setAuthAndToken(BuildContext context, String token, String userId) {
    Provider.of<AppData>(context,listen: false).setToken(token);
    Provider.of<AppData>(context,listen: false).setUserId(userId);
  }

  static void toLoginToPolar(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.loginToPolar);

  }

// Services
}

