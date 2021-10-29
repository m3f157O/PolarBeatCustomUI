import 'package:custom_polar_beat_ui_v2/view/client_menu_api.dart';
import 'package:custom_polar_beat_ui_v2/view/get_token_from_polar.dart';
import 'package:custom_polar_beat_ui_v2/view/login_to_polar_web.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:custom_polar_beat_ui_v2/view/starting_screen.dart';
import 'package:custom_polar_beat_ui_v2/model/phases.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';



void main() {
  runApp(
    const MaterialApp(
      title: 'Named Routes Demo',

      home: GetAuthCodeFromPolar(),

    ),
  );
}


/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
const authDomain = 'custompolarinterface.eu.auth0.com';
const authClient = 'rsy7ZGINmoO9EHFRiSzJddP8r2pR3wAr';
const polarClient = '21e2f720-3832-42d4-b8ad-3d8ef0067023';
const polarSecret = 'b9ea73d7-0189-4dce-ba0a-fce95c7ebd74';  //TODO PROTECT THIS

const authRedirectUri = 'com.auth0.custompolarinterface://login-callback';
const authIssuer = 'https://$authDomain';

const Map<PHASE,Widget> identifier = {
  PHASE.startingUserMenu: StartingScreen(),
  PHASE.loginToPolar:LoginToPolarWeb(),
  PHASE.getTokenFromPolar:GetTokenFromPolar(),
  PHASE.viewMenu: ClientMenu(),
  PHASE.showData:ShowData(),
};

/// -----------------------------------
///           VIEW MINI-CONTROLLER
/// -----------------------------------
class GetAuthCodeFromPolar extends StatefulWidget {
  const GetAuthCodeFromPolar({Key? key}) : super(key: key);


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
  void initState() {//TODO SYNCH THIS PLEASE


  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => AppState()),
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
