import 'package:custom_polar_beat_ui_v2/view/client_menu_api.dart';
import 'package:custom_polar_beat_ui_v2/view/get_token_from_polar.dart';
import 'package:custom_polar_beat_ui_v2/view/login_to_polar_web.dart';
import 'package:custom_polar_beat_ui_v2/view/view_and_send_authcode.dart';
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



/// -----------------------------------
///           VIEW MINI-CONTROLLER
/// -----------------------------------
class GetAuthCodeFromPolar extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return Display();
  }

}
class Display extends State<GetAuthCodeFromPolar> {


  Widget getWidget(BuildContext context) {

    if(context.select<AppState,int>((value) =>value.state)==0) {
      print('LOGIN');
      return const LoginToPolarWeb();
    }
    else if(context.select<AppState,int>((value) =>value.state)==1) {
      print('VIEW CODE');
      return const ViewAndSendAuthCode();
    }
    else if(context.select<AppState,int>((value) =>value.state)==2){
      print('GET TOKEN');
      return const GetTokenFromPolar();
    } else {
      print('CLIENT MENU');
      return const ClientMenuAPI();
    }

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
              return getWidget(context);
            }
        )
    );
  }
}
