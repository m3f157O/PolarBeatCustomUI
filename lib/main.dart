/// -----------------------------------
///          External Packages        
/// -----------------------------------

import 'package:flutter/material.dart';

/// -----------------------------------
///           Auth0 Variables          
/// -----------------------------------

/// -----------------------------------
///           Profile Widget           
/// -----------------------------------

/// -----------------------------------
///            Login Widget           
/// -----------------------------------

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
  late String errorMessage;
  late String name;
  late String picture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth0 Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auth0 Demo'),
        ),
        body: Center(
          child: Text('Implement User Authentication'),
        ),
      ),
    );
  }
}