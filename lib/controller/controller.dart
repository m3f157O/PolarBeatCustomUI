
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';

/// -----------------------------------
///           CONTROLLER
/// -----------------------------------
const POLAR_CLIENT_ID = '21e2f720-3832-42d4-b8ad-3d8ef0067023';

class BaseCommand {
  // Models

  void toDebugAuthCode(BuildContext context,String code) {
    Provider.of<AppData>(context, listen: false).setCode(code);
    Provider.of<AppState>(context,listen: false).setstate(PHASE.debugAuthCode);

  }
  void toGetTokenFromPolar(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.getTokenFromPolar);

  }
  void toViewMenu(BuildContext context) {
    Provider.of<AppState>(context,listen: false).setstate(PHASE.viewMenu);

  }

  static void setAuthAndToken(BuildContext context, String token, String userId) {
    Provider.of<AppData>(context,listen: false).setToken(token);
    Provider.of<AppData>(context,listen: false).setUserId(userId);
  }

  String getToken(BuildContext context) {
    return Provider.of<AppData>(context,listen: false).token;
  }

  String getAuth(BuildContext context) {
    return Provider.of<AppData>(context,listen: false).userid;
  }
// Services
}

