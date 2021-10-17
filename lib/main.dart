/// -----------------------------------
///          External Packages        
/// -----------------------------------

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;



/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------
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
        '/': (context) =>  const GetAuthCodeFromPolar(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    ),
  );
}






class GetAuthCodeFromPolar extends StatelessWidget {
  const GetAuthCodeFromPolar({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebViewWebPage(),
    );
  }
}

class WebViewWebPage extends StatefulWidget {
  const WebViewWebPage({Key? key}) : super(key: key);

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
        title: const Text("Authenticating..."),
      ),
      body: InAppWebView(
        initialUrlRequest:
        URLRequest(url: Uri.parse("https://flow.polar.com/oauth2/authorization?response_type=code&client_id=$POLAR_CLIENT_ID")),
        onLoadStart: (controller, url) {
          var callback='com.auth0.custompolarinterface://login-callback?code=';
          if(url!.toString().contains(callback,0)) {
            String code=url.toString().substring(callback.length);
            Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(
                builder: (context) => ViewCodeBeforeSending(text : code)));
            }
        }
      ),
    );

  }
}





class ViewCodeBeforeSending extends StatelessWidget {

  final String text;
  const ViewCodeBeforeSending({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                                  builder: (context) => SendCodeToPolar(code : text))),
                              child: const Text("SEND AUTHENTICATION CODE TO POLAR"),
                            ),
                          ],
                        )                   ]
                      )
                    ]
                )
            )
    );
  }
}








class SendCodeToPolar extends StatefulWidget {

  final String code;
  const SendCodeToPolar({Key? key, required this.code}) : super(key: key);


  @override
  TokenRequestToPolar createState() => TokenRequestToPolar(code);
}

class TokenRequestToPolar extends State<SendCodeToPolar> {

  final String code;
  late Future<String> msg;

  TokenRequestToPolar(this.code);

  Future<String> fetchAlbum() async {
    var response = await http.post(Uri.parse('https://polarremote.com/v2/oauth2/token'),
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


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      String token= "Bearer " + user['access_token'];

      String id="User_id_"+user['x_user_id'].toString();


      // then parse the JSON.
      return id+token.toString(); //really don't want to use a list, I'd rather parse the whole string
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return response.statusCode.toString();
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
      title: 'GET YOUR TOKEN',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PRESS AUTHENTICATE TO GET YOUR TOKEN'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: msg,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String userId=snapshot.data!.substring(0,snapshot.data!.indexOf("B"));
                String token=snapshot.data!.substring(snapshot.data!.indexOf("B"));
                print(userId);
                print(token);
                return ElevatedButton(
                  onPressed: () => Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                      builder: (context) => RegisterClientAPI(userToken: token, userId: userId))),
                  child: Text("AUTENTICATE " + token),

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






class RegisterClientAPI extends StatelessWidget {

  const RegisterClientAPI({Key? key, required this.userToken, required this.userId}) : super(key: key);


  final String userToken;
  final String userId;

  void fetchAlbum() async {
    var response = await http.post(Uri.parse('https://www.polaraccesslink.com/v3/users'),
        headers:
        {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': userToken
        },
        body:
        jsonEncode({"member-id": userId})
    );


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      print(user['registration-date']);
      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      print(response.contentLength);
    }
  }

  void fetchActivities() async {
    var response = await http.get(Uri.parse('https://www.polaraccesslink.com/v3/notifications'),
        headers:
        {
          'Authorization': 'Basic MjFlMmY3MjAtMzgzMi00MmQ0LWI4YWQtM2Q4ZWYwMDY3MDIzOmI5ZWE3M2Q3LTAxODktNGRjZS1iYTBhLWZjZTk1YzdlYmQ3NA==',
          'Accept': 'application/json',
        },
    );


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      print(user["available-user-data"]);
      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      print(response.body);
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

            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => fetchAlbum(),
                    child: const Text("REGISTER USER"),
                  ),
                  ElevatedButton(
                    onPressed: () => fetchActivities(),
                    child: const Text("GET NOTIFICATIONS"),
                  ),
                ],
            )
        )
      ),

    );
  }
}

