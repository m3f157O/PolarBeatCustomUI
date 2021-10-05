/// -----------------------------------
///          External Packages        
/// -----------------------------------

import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auth0/auth0.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

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
///            Games Widget
/// -----------------------------------

class Graph extends StatelessWidget
{

  void _increment(BuildContext context) {
    Provider.of<Counter>(context, listen: false).incrementCounter(context);
  }


  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context).count;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => _increment(context),
          child: const Text('Increment'),
        ),
        const SizedBox(width: 16),
        Text('Count: $counter'),
      ],
    );
  }

}
/*
class Graph extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return GraphState();
  }


}


class GraphState extends State<Graph> {
  int rolled=0;

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


  List<Widget> getWidget() {
    var pwdWidgets = <Widget>[];

    if(rolled==0){

      pwdWidgets.add(const Game1());

    }
    else if(rolled==1)
    {
      pwdWidgets.add(const Game2());
    }
    else
    {
      pwdWidgets.add(Graph());
    }
    return pwdWidgets;

  }
  void roll() {
    setState(() {
      // This call to setState tells the Flutter framework
      // that something has changed in this State, which
      // causes it to rerun the build method below so that
      // the display can reflect the updated values. If you
      // change _counter without calling setState(), then
      // the build method won't be called again, and so
      // nothing would appear to happen.
      if(rolled<2) {
        rolled++;
      }
      else {
        rolled=0;
      }
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


class Game1 extends StatelessWidget {
  const Game1({Key? key}) : super(key: key);




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
            onPressed: () {  },
            child: const Text('raatto')
        ),
      ],
    );
  }
}

class Game2 extends StatelessWidget {
  const Game2({Key? key}) : super(key: key);




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
            onPressed: () {  },
            child: const Text('raatto')
        ),
      ],
    );
  }
}
*/
/// -----------------------------------
///            Login Widget           
/// -----------------------------------
class Login extends StatelessWidget {
  final loginAction;
  final String loginError;

  const Login(this.loginAction, this.loginError);


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
            onPressed: loginAction,
            child: const Text('LOGIN')
        ),
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


  late String errorMessage='NO GOOD';
  late String name='RAT2.0';
  late String picture='BIG';



  void loginAction()  {
    setState(() {
      isLoggedIn=true;
    });

      print('logged in');

  }


  void logoutAction()  {
    setState(() {
      isLoggedIn=false;
    });

    print('logged out');

  }



  List<Widget> getWidget() {
    var pwdWidgets = <Widget>[];

    if(isLoggedIn){

      pwdWidgets.add(Profile(logoutAction,name,picture));
      pwdWidgets.add(Graph());

    }
    else
    {
      pwdWidgets.add(Login(loginAction,errorMessage));
    }
    return pwdWidgets;

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
                  appBar: AppBar(
                      title: Text('Auth0 Demo'),
                      ),
                      body: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                      Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: getWidget()
                                      )
                                      ]
                                )
                              )
              )
    );
  }

}
