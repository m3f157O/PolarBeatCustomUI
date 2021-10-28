
import 'package:custom_polar_beat_ui_v2/view/deserialization.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';

/// -----------------------------------
///           MODEL
/// -----------------------------------





class AppState extends ChangeNotifier {


  PHASE _state=PHASE.startingUserMenu;


  PHASE get state => _state;

  void setstate(PHASE i) {
    _state = i;
    notifyListeners();
  }


// Eventually other stuff would go here, appSettings, premiumUser flags, currentTheme, etc...
}

class AppData extends ChangeNotifier {


  String _code='emtpy';
  String _token='emtpy';

  Available userData= Available(0,'empty','empty');
  String get token => _token;

  void setToken(String value) {
    _token = value;
  }











  void addData(Available value)
  {
    userData=value;
  }

  String _userid='emtpy';


  String get userid => _userid;

  void setUserId(String value) {
    _userid = value;
  }

  String get code => _code;

  void setCode(String i) {
    _code = i;
    notifyListeners();
  }


}

