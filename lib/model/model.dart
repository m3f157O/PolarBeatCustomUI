
import 'package:flutter/cupertino.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';
import 'package:flutter/material.dart';

import 'db_model.dart';

/// -----------------------------------
///           MODEL
/// -----------------------------------


enum SORT {
  date,
  calories,
  average,
  duration,
  maximum,
}



class AppState extends ChangeNotifier {


  //CAREFUL, using setters gives me problems
  Map FastSortAdapter=
  {
    "uploadtime":0,
    "calories":1,
    "average":2,
    "duration":3,
    "maximum":4,
  };

  int sort=0;
  int totalCalories=0;
  int localCalories=0;
  int localDistance=0;
  Duration totalTime=Duration.zero;
  Color main=Colors.white;
  Color text=Colors.white;
  Color second=Colors.lightBlue;
  int totalDistance=0;
  bool asc=false;
  PHASE _state=PHASE.startingUserMenu;

  List<Map<dynamic,dynamic>> savedActivities=[];
  List<Map<dynamic,dynamic>> newActivities=[];
  List<Map<dynamic,dynamic>> topCalories=[];
  List<Map<dynamic,dynamic>> topDuration=[];
  List<Map<dynamic,dynamic>> topDistance=[];
  Map<dynamic,dynamic> profile={"firstname":"empty","lastname":"empty"};



  PHASE get state => _state;

  void setstate(PHASE i) {
    _state = i;
    notifyListeners();
  }


  void setColor(Color i) {
    main=i;
    notifyListeners();
  }

  void setSecond(Color i) {
    second=i;
    notifyListeners();
  }

  void setSort(String i) {
    print("setting sort to");
    print(FastSortAdapter[i]);

    sort=FastSortAdapter[i];
    notifyListeners();
  }

  void setCalories(int i) {
    print("setting calories to");
    print(i);
    totalCalories=i;
    notifyListeners();
  }

  void setLocalCalories(int i) {
    print("setting calories to");
    print(i);
    localCalories=i;
    notifyListeners();
  }

  void setLocalDistance(int i) {
    print("setting calories to");
    print(i);
    localDistance=i;
    notifyListeners();
  }

  void setDistance(int i) {
    print("setting distance to");
    print(i);

    totalDistance=i;
    notifyListeners();
  }

  void setTime(Duration i) {
    print("setting calories to");
    print(i);

    totalTime=i;
    notifyListeners();
  }

  void toogleAsc() {
    asc=!asc;
    savedActivities=List.from(savedActivities.reversed);
    notifyListeners();
  }


  void setActivities(List<Map<dynamic,dynamic>> i) {
    savedActivities = i;
    notifyListeners();
  }

  void setDurationActivities(List<Map<dynamic,dynamic>> i) {
    topDuration = i;

    print("JUST SET DURATION");

    notifyListeners();
  }

  void setCaloriesActivities(List<Map<dynamic,dynamic>> i) {
    topCalories = i;
    print("JUST SET cALORIES");
    for(int i=0;i<topCalories.length;i++)
      print(topCalories.elementAt(i)["calories"]);
    notifyListeners();
  }

  void setDistanceActivities(List<Map<dynamic,dynamic>> i) {
    topDistance = i;

    print("JUST SET DISTANCE");
    notifyListeners();
  }


  //not complete
  void editActivity(int i, dynamic field, dynamic value) {
    DataBase().editActivities(savedActivities.elementAt(0),field,value);
    notifyListeners();
  }

  void clearNewBuffer() {
    newActivities=[];
    notifyListeners();

  }

  void setNewActivities(List<Map<String,Object>> i) {
    newActivities = i;
    notifyListeners();
  }

  void setProfile(Map<dynamic,dynamic> i) {
    profile = i;
    notifyListeners();
  }



// Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}


