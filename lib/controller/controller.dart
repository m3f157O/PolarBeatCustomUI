
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
/// 1. IF YOU NEED TO SHOW MORE DATA, ADD THE CORRESPONDING LISTENED VALUE IN THE MODEL, AND ACCORDING TO THE FOLLOWING, THE CORRECT METHOD IN EACH COMPONENT
/// 2. IF YOU NEED TO MAKE THAT DATA PERSISTENT, MAKE IT CONSISTENT WITH A DB TABLE/BLOB
/// 3. IF YOU NEED TO ACQUIRE DATA, HERE IS WHAT I SUGGEST:
///   -NON-PERSISTENT DATA: INVOKE VIEW->CONTROLLER->NET_CONTROLLER AND GET IT AS A RETURN ARGUMENT
///   -PERSISTENT DATA: INVOKE VIEW->CONTROLLER->MODEL_DB. IF IT'S A LARGE SIZE OF DATA, I DON'T RECOMMEND GETTING IT AS A RETURN ARGUMENT.
///                     IF IT'S NOT A "FINAL" DATA, I RECOMMEND SETTING IT AS AN OBSERVED VALUE, TO MAKE IT AVAILABLE IN REAL TIME AND AVOIDING
///                     EXPLICIT METHOD INVOCATIONS
/// 3a. DONT LISTEN ON VALUES THAT CHANGE SPORADICALLY, AS IT IS A WASTE OF RESOURCES
/// 4. NOW YOU CAN CREATE A VIEW. TO DO SO, YOU NEED TO ASSOCIATE IT TO A PHASE. ONCE YOU HAVE ASSOCIATED IT WITH A PHASE YOU CAN UPDATE THE PHASE MACHINE TABLE IN THE
///    main.dart CLASS. CHOOSE THE PHASE THAT YOU WANT TO BE ITS PREDECESSOR PHASE, AND CREATE A CORRESPONDING CONTROLLER METHOD, WHICH WILL BE CALLED BY ITS PREDECESSOR TO MAKE THE TRANSITION.
///
/// EXAMPLE: I NEED TO ACQUIRE THE EXERCISE FROM POLAR TM (NOT PERSISTENT)
/// ///      1. I ADD GetExerciseData METHOD TO THE NetController, WHICH RETURNS THE DATA, ADD A METHOD TO THE Controller TO USE IT AND GET ITS RETURN ARGUMENT.
///          1a. NetController makes an async call to remote
///          2. I CREATE THE VIEW Client_MEnu_Api AND CREATE THE CORRESPONDING METHOD TO ACQUIRE AND USE THE DATA. I ASSOCIATE IT WITH THE PHASE clientMenu, AND CHOOSE ITS PREDECESSOR,
///             THAT WILL BE get_token_from_polar
///          3. I CHOOSE WHICH ACTION WITHIN THAT VIEW CAUSES THE CONTROLLER TO MODIFY THE MODEL PHASE TO clientMenu (WHICH IS CONSTANTLY OBSERVED BY THE STATE MACHINE) CAUSING THE VIEW TO
///             TRANSITION TO THE ASSOCIATED PHASE'S ONE.
///          4. NOW, WHEN WITHIN THE VIEW get_token_from_polar, A CERTAIN USER ACTION CAUSES THE TRANSITION TO HAPPEN AND THE DATA TO BE SHOWN
/// EXAMPLE: I NEED TO ACQUIRE THE EXERCISE FROM POLAR TM (PERSISTENT)
/// ///      1. I ADD GetExerciseData METHOD TO THE db_model, WHICH SETS THE CORRESPONDING OBSERVED DATA IN THE MDDEL, ADD A METHOD TO THE Controller TO USE IT.
/// ///      1a. IF ITS A LARGE QUANTITY OF DATA, SPLIT THEM IN ALREADY STORED AND REMOTE, AND ALWAYS MAKE TWO DIFFERENT CALLS, TO INCREASE PARALLELISM
///              EXAMPLE: I NEED TO GET THE NEW EXERCISES, AND ALREADY HAVE THE PREVIOUS ONE. I MAKE TWO SEPARATE CALLS IN PARALLEL, INSTEAD OF ASKING FOR THE NEW AND LOADING THE OLD AND VICE VERSA
///          2a. MAKE db_model CALLS TRANSPARENT, AS IT WILL SET AN OBSERVED VALUE, IT COULD BE AS WELL A void CALL
///          2. I CREATE THE VIEW Client_MEnu_Api AND INJECT IT WITH THE CORRECT PROVIDER DEPENDENCY, TO OBSERVE AND USE THE DATA. I ASSOCIATE IT WITH THE PHASE clientMenu, AND CHOOSE ITS PREDECESSOR,
///             THAT WILL BE get_token_from_polar
///          3. I CHOOSE WHICH ACTION WITHIN THAT VIEW CAUSES THE CONTROLLER TO MODIFY THE MODEL PHASE TO clientMenu (WHICH IS CONSTANTLY OBSERVED BY THE STATE MACHINE) CAUSING THE VIEW TO
///             TRANSITION TO THE ASSOCIATED PHASE'S ONE.
///          4. NOW, WHEN WITHIN THE VIEW get_token_from_polar, A CERTAIN USER ACTION CAUSES THE TRANSITION TO HAPPEN AND THE DATA TO BE SHOWN, IN THIS CASE FASTER BECAUSE IT WAS OBSERVED DATA
///
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

  void toggleAsc(BuildContext context) {
    Provider.of<AppState>(context,listen: false).toogleAsc();

  }
  void toInitial(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.startingUserMenu);

  }

  Future<bool> fetchToken() async {
    return await DataBase().fetchAccessToken();
  }

  Future<bool> fetchProfile(BuildContext context) async {
    return await lock.synchronized(() async {
      return await DataBase().fireUserInfoRequest(context);
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

  Future<bool> fetchActivities(BuildContext context) {
    return DataBase().fetchActivities(context);
  }

  Future<bool> fetchActivitiesByDate(BuildContext context) {
    return DataBase().fetchActivitiesBy(context,"uploadtime");
  }

  Future<bool> fetchActivitiesByDuration(BuildContext context) {
    return DataBase().fetchActivitiesBy(context,"duration");
  }

  Future<bool> fetchActivitiesByCalories(BuildContext context) {
    return DataBase().fetchActivitiesBy(context,"calories");
  }

  Future<bool> fetchActivitiesByMaximum(BuildContext context) {
    return DataBase().fetchActivitiesBy(context,"maximum");
  }

  Future<bool> fetchActivitiesByAverage(BuildContext context) {
    return DataBase().fetchActivitiesBy(context,"average");
  }

  Future<bool> fetchSavedActivities(BuildContext context) {
    return DataBase().fetchSavedActivities(context);
  }

// Services
}

