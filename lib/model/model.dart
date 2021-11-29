
import 'package:flutter/cupertino.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';
import 'package:sqflite/sqflite.dart';

import 'db_model.dart';
import 'fast_sort_enum.dart';

/// -----------------------------------
///           MODEL
/// -----------------------------------





class AppState extends ChangeNotifier {


  Map FastSortAdapter=
  {
    "uploadtime":0,
    "calories":1,
    "average":2,
    "duration":3,
    "maximum":4,
  };

  int sort=0;
  bool asc=false;

  PHASE _state=PHASE.startingUserMenu;
  List<Map<dynamic,dynamic>> savedActivities=[];
  List<Map<dynamic,dynamic>> newActivities=[];
  Map<dynamic,dynamic> profile={};



  PHASE get state => _state;

  void setstate(PHASE i) {
    _state = i;
    notifyListeners();
  }

  void setSort(String i) {
    print("setting sort to");
    print(FastSortAdapter[i]);

    sort=FastSortAdapter[i];
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


