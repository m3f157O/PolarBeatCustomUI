
import 'package:custom_polar_beat_ui_v2/model/db_model.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';
import 'package:synchronized/synchronized.dart';

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
  var lock = Lock();
  static getController(){
  return _instance;
  }
  void toDebugAuthCode(BuildContext context,String code) {
    DataBase().updateTokenTable("code", code);
    Provider.of<AppState>(context,listen: false).setstate(PHASE.getTokenFromPolar);

  }

  Future<bool> fetchToken() async {
    return await DataBase().fetchAccessToken();
  }

  Future<Map<String,Object>> fetchProfile(BuildContext context) async {
    return await lock.synchronized(() async {
      return Map.from(await DataBase().fireUserInfoRequest(context));
    });
  }

   Future<String> fetchTokenOnStart() async {

     await lock.synchronized(() async {
     // Only this block can run (once) until done

       await DataBase().initDatabase();
       });

     return await lock.synchronized(() async {
       // Only this block can run (once) until done
       return await DataBase().fetchFromTokenTable('bearer');
     });


  }


   void updateToken(String token) async {
    DataBase().updateTokenTable("bearer", token);
  }


   void reset(BuildContext context) async {
     await lock.synchronized(() async {
       await DataBase().reset();
     });

   }

   Future<String> fetchId() async {
    return await DataBase().fetchFromTokenTable('id');
  }

   void updateId(String id) async {
    DataBase().updateTokenTable("id", id);
  }




  void toGetTokenFromPolar(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.getTokenFromPolar);

  }
  void toViewMenu(BuildContext context) {



    Provider.of<AppState>(context,listen: false).setstate(PHASE.viewMenu);

  }


   void toLoginToPolar(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.loginToPolar);

  }

  Future<void> registerUser() async {
    await lock.synchronized(() async {
      // Only this block can run (once) until done
      await DataBase().registerUser();

    });

  }

  Future<List<Map<String,Object>>> fetchActivities(BuildContext context) {
    return DataBase().fetchActivities(context);
  }

  Future<bool> fetchSavedActivities(BuildContext context) {
    return DataBase().fetchSavedActivities(context);
  }

// Services
}

