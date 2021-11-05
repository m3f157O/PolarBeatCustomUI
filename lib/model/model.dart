
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


