
import 'package:flutter/cupertino.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';

/// -----------------------------------
///           MODEL
/// -----------------------------------





class AppState extends ChangeNotifier {


  PHASE _state=PHASE.startingUserMenu;
  List<Map<dynamic,dynamic>> savedActivities=[];
  List<Map<dynamic,dynamic>> newActivities=[];
  Map<dynamic,dynamic> profile={};
  bool asc=false;

  PHASE get state => _state;

  void setstate(PHASE i) {
    _state = i;
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


