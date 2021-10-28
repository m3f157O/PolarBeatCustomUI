import 'package:custom_polar_beat_ui_v2/view/client_menu_api.dart';
import 'package:custom_polar_beat_ui_v2/view/get_token_from_polar.dart';
import 'package:custom_polar_beat_ui_v2/view/login_to_polar_web.dart';
import 'package:custom_polar_beat_ui_v2/view/view_and_send_authcode.dart';
import 'package:flutter/cupertino.dart';


enum PHASE {
  startingUserMenu,
  loginToPolar,
  getTokenFromPolar,
  viewMenu,
  showData,
}

