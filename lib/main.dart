/// -----------------------------------
///          External Packages        
/// -----------------------------------

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:auth0/auth0.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();


/// -----------------------------------
///           Providers Widget
/// -----------------------------------

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class Counter extends ChangeNotifier {

 /* late Future<Album> futureAlbum;

  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Widget futureBuilder(BuildContext context){
    return FutureBuilder<Album>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }




  void firstRequest() {
    futureAlbum=fetchAlbum();
    print(futureAlbum);
    notifyListeners();
  }

  */
}


/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
var code='empty';
var id='54588317';
const AUTH0_DOMAIN = 'custompolarinterface.eu.auth0.com';
const AUTH0_CLIENT_ID = 'rsy7ZGINmoO9EHFRiSzJddP8r2pR3wAr';
const POLAR_CLIENT_ID = '21e2f720-3832-42d4-b8ad-3d8ef0067023';
const POLAR_CLIENT_SECRET = 'b9ea73d7-0189-4dce-ba0a-fce95c7ebd74';

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
        '/': (context) =>  PolarAuth(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    ),
  );
}






class PolarAuth extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewWebPage(),
    );
  }
}

class WebViewWebPage extends StatefulWidget {
  @override
  _WebViewWebPageState createState() => _WebViewWebPageState();
}



class _WebViewWebPageState extends State<WebViewWebPage>
{
  static const url = 'https://flow.polar.com/oauth2/authorization?response_type=code&client_id=$POLAR_CLIENT_ID';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview App"),
      ),
      body: Container(
        child: InAppWebView(
          initialUrl: url,
          initialHeaders: {},
          initialOptions: {},
          onWebViewCreated: (InAppWebViewController controller) {
          },
          onLoadStart: (InAppWebViewController controller, String url) {
            var callback='com.auth0.custompolarinterface://login-callback?code=';
            if(url.contains(callback,0)) {
              code=url.substring(callback.length);
              Navigator.of(context, rootNavigator: true)
                  .push(MaterialPageRoute(
                  builder: (context) => const DebugStuff()));
            }
          },

      ),

      )
    );

  }
}




class DebugStuff extends StatelessWidget {

  const DebugStuff({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: Counter(),
      ),
    ],
        child : MaterialApp(
            title: 'Auth0 2',
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
                              onPressed: () => Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(
                                  builder: (context) => const PolarTokenGetter())),
                              child: Text(code),
                            ),
                          ],
                        )                   ]
                      )
                    ]
                )
            )
        )
    );
  }
}











class RegisterUserToPolar extends StatelessWidget {

  const RegisterUserToPolar({Key? key, required this.userToken, required this.userId}) : super(key: key);


  final String userToken;
  final String userId;

  void fetchAlbum() async {
    var response = await http.post('https://www.polaraccesslink.com/v3/users',
        headers:
        {
          "Authorization": userToken
        },
        body:
        {
          "member-id": userId
        }
    );
    print(userToken);
    print(userId);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      var id= user['registration-date'];
      print(id);
      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(

                child:  ElevatedButton(
                  onPressed: () => fetchAlbum(),
                  child: const Text("HELLO"),
                )



              // By default, show a loading spinner.

          ),
        ),
      );
  }

}






class PolarTokenGetter extends StatefulWidget {
  const PolarTokenGetter({Key? key}) : super(key: key);


  @override
  AuthCodeRequestToPolar createState() => AuthCodeRequestToPolar();
}


class AuthCodeRequestToPolar extends State<PolarTokenGetter> {

  late Future<String> msg;

  Future<String> fetchAlbum() async {
    var response = await http.post('https://polarremote.com/v2/oauth2/token',
        headers:
        {
          'Authorization': 'Basic MjFlMmY3MjAtMzgzMi00MmQ0LWI4YWQtM2Q4ZWYwMDY3MDIzOmI5ZWE3M2Q3LTAxODktNGRjZS1iYTBhLWZjZTk1YzdlYmQ3NA==',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json;charset=UTF-8'
        },
        body:
        {
          "code": code,
          "grant_type": "authorization_code"
        }
        );

    var token;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      token= "Bearer <" + user['access_token'] + ">";
      var id= user['x_user_id'];
      print(id);
      print(token);
      // then parse the JSON.
      return token.toString();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return '404';
    }
  }


  @override
  void initState() {
    super.initState();
    msg=fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: msg,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ElevatedButton(
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                      builder: (context) => RegisterUserToPolar(userToken: snapshot.data!, userId: id,))),
                  child: Text("AUTENTICATE " + snapshot.data!),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }


              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
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