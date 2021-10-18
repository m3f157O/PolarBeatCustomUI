
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
/// -----------------------------------
///           CONTROLLER
/// -----------------------------------
const POLAR_CLIENT_ID = '21e2f720-3832-42d4-b8ad-3d8ef0067023';

class BaseCommand {
  // Models



  void toViewCode(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(1);

  }
  void toViewToken(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(2);

  }
  void registerUser(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(3);

  }
  void setCode(BuildContext context, String code) {
    Provider.of<AppData>(context, listen: false).setCode(code);
  }
// Services
}

