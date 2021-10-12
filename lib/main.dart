/// -----------------------------------
///          External Packages        
/// -----------------------------------

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:auth0/auth0.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


/// -----------------------------------
///           Providers Widget
/// -----------------------------------


class Counter extends ChangeNotifier {
  var _count = 90;

  get count => _count;

  void incrementCounter(BuildContext context) {
    _count += 1;
    notifyListeners();
  }
}


/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------

const AUTH0_DOMAIN = 'custompolarinterface.eu.auth0.com';
const AUTH0_CLIENT_ID = 'rsy7ZGINmoO9EHFRiSzJddP8r2pR3wAr';

const AUTH0_REDIRECT_URI = 'com.auth0.custompolarinterface://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const AuthenticatorScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const LogoutScreen(),
      },
    ),
  );
}



class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logout Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          // Within the `FirstScreen` widget
          onPressed: () {
            secureStorage.delete(key: 'refresh_token');
            Navigator.pop(context);

          },
          child: const Text('LOGOUT'),
        ),
      ),
    );
  }
}




class AuthenticatorScreen extends StatelessWidget {
  const AuthenticatorScreen({Key? key}) : super(key: key);


  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }


  Future<void> loginAction(BuildContext context) async {

    try {
      final AuthorizationTokenResponse result =
      await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
            AUTH0_CLIENT_ID,
            AUTH0_REDIRECT_URI,
            issuer: 'https://$AUTH0_DOMAIN',
            scopes: ['openid']
        ),
      );




      final idToken = parseIdToken(result.idToken);
      print(idToken);
      print('above me is a token');
      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);

    } catch (e, s) { }
    Navigator.pushNamed(context, '/second');

  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: Counter(),
      ),
    ],
        child : MaterialApp(
            title: 'Auth0 Demo',
            home: Scaffold(

                body: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () => loginAction(context),
                                child: const Text('LOGIN'),
                              ),
                            ],
                          ),                          ]
                                )
                    ]
                )
            )
        )
    );
  }

}