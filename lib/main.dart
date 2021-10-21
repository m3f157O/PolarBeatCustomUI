import 'package:custom_polar_beat_ui_v2/view/client_menu_api.dart';
import 'package:custom_polar_beat_ui_v2/view/get_token_from_polar.dart';
import 'package:custom_polar_beat_ui_v2/view/login_to_polar_web.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:custom_polar_beat_ui_v2/view/view_and_send_authcode.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',

      initialRoute: '/',
      routes: {
        '/': (context) =>  GetAuthCodeFromPolar(),
      },
    ),
  );
}


/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
const AUTH0_DOMAIN = 'custompolarinterface.eu.auth0.com';
const AUTH0_CLIENT_ID = 'rsy7ZGINmoO9EHFRiSzJddP8r2pR3wAr';
const POLAR_CLIENT_ID = '21e2f720-3832-42d4-b8ad-3d8ef0067023';
const POLAR_CLIENT_SECRET = 'b9ea73d7-0189-4dce-ba0a-fce95c7ebd74';

const AUTH0_REDIRECT_URI = 'com.auth0.custompolarinterface://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

const Map<PHASE,Widget> identifier = {
  PHASE.loginToPolar:LoginToPolarWeb(),
  PHASE.debugAuthCode:DebugAuthCode(),
  PHASE.getTokenFromPolar:getTokenFromPolar(),
  PHASE.viewMenu: ClientMenu(),
  PHASE.showData:ShowData(),
};

/// -----------------------------------
///           VIEW MINI-CONTROLLER
/// -----------------------------------
class GetAuthCodeFromPolar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ViewLogic();
  }

}


class ViewLogic extends State<GetAuthCodeFromPolar> {


  Widget displayState(BuildContext context) {

    return identifier[context.select<AppState,PHASE>((value) =>value.state)] ?? const LoginToPolarWeb();

  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => AppState()),
          ChangeNotifierProvider(create: (c) => AppData()),
        //Provider(create: (c) => UserService()),
        ],
        child: Builder(
            builder: (context) {
              // No longer throws
              return displayState(context);
            }
        )
    );
  }
}
