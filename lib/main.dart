/// -----------------------------------
///          External Packages        
/// -----------------------------------

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auth0/auth0.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

/// -----------------------------------
///           Auth0 Variables          
/// -----------------------------------

const AUTH0_DOMAIN = 'dev-otg2dqth.us.auth0.com';
const AUTH0_CLIENT_ID = '7fy6wO0sjYrYVKiUstQbecC9FAQ1IJ93';

const AUTH0_REDIRECT_URI = 'com.auth0.flutterdemo://login-callback';
const AUTH0_ISSUER = 'https://$AUTH0_DOMAIN';

/// -----------------------------------
///           Profile Widget           
/// -----------------------------------

class Profile extends StatelessWidget {
  final logoutAction;
  final String name;
  final String picture;

  Profile(this.logoutAction, this.name, this.picture);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 4.0),
            shape: BoxShape.circle,

          ),
        ),
        SizedBox(height: 24.0),
        Text('Name: $name'),
        SizedBox(height: 48.0),
        RaisedButton(
          onPressed: () {
            logoutAction();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
/// -----------------------------------
///            Login Widget           
/// -----------------------------------
class Login extends StatefulWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);

  @override
  State<StatefulWidget> createState() {
      return _DogState();
  }


}


class _CounterState extends State<Login> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework
      // that something has changed in this State, which
      // causes it to rerun the build method below so that
      // the display can reflect the updated values. If you
      // change _counter without calling setState(), then
      // the build method won't be called again, and so
      // nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _increment,
          child: const Text('Increment'),
        ),
        const SizedBox(width: 16),
        Text('Count: $_counter'),
      ],
    );
  }
}

class _DogState extends State<Login> {
  int _counter = 0;
  bool state=false;


  void _toggleFavorite() {
    setState(() {
      state= !state;
    });

  }

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework
      // that something has changed in this State, which
      // causes it to rerun the build method below so that
      // the display can reflect the updated values. If you
      // change _counter without calling setState(), then
      // the build method won't be called again, and so
      // nothing would appear to happen.
      if(!state) {
        return;
      }
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _increment,
          child: state
              ? const Text('Increment')
              : const Text('OFFLINE')
        ),
        ElevatedButton(
          onPressed: _toggleFavorite,
          child: state
              ? const Text('Disable')
              : const Text('Enable')
        ),
        const SizedBox(width: 16),
        Text('Count: $_counter'),
      ],
    );
  }
}

/// -----------------------------------
///                 App
/// -----------------------------------

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/// -----------------------------------
///              App State            
/// -----------------------------------

class _MyAppState extends State<MyApp> {

  bool isBusy = false;
  bool isLoggedIn = false;

  bool isCounter = false;
  bool isProfile = false;
  bool isDog = false;


  late String errorMessage='cic';
  late String name='rat';
  late String picture='dog';



  void loginAction()  {
    setState(() {  });

      print('hello');

  }

  void dogAction()  {
    setState(() { isDog=!isDog; });

    print('hello');

  }


  void profileAction()  {
    setState(() { isProfile=!isProfile; });

    print('hello');

  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth0 Demo'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: isProfile
                      ? Profile(loginAction,name,picture)
                      : Login(loginAction,errorMessage)
                ),
                Container(
                  child: isDog
                      ? Profile(loginAction,name,picture)
                      : Login(loginAction,errorMessage)
                ),
            ],
          ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: profileAction,
                    child: isProfile
                        ? const Text('Disable')
                        : const Text('Enable')
                ),
                ElevatedButton(
                    onPressed: dogAction,
                    child: isDog
                        ? const Text('Disable')
                        : const Text('Enable')
                ),
              ],
            ),

          ],
        )
      )
    );
  }

}
/*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth0 Demo'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: isProfile
                      ? Profile(loginAction,name,picture)
                      : Login(loginAction,errorMessage)
                ),
                Container(
                  child: isDog
                      ? Profile(loginAction,name,picture)
                      : Login(loginAction,errorMessage)
                ),
            ],
          ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: profileAction,
                    child: isProfile
                        ? const Text('Disable')
                        : const Text('Enable')
                ),
                ElevatedButton(
                    onPressed: dogAction,
                    child: isDog
                        ? const Text('Disable')
                        : const Text('Enable')
                ),
              ],
            ),

          ],
        )
      )
    );
  }
*/