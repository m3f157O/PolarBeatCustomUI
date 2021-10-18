
import 'dart:convert';

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart'; //TODO <---this is bad


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class GetTokenFromPolar extends StatefulWidget {

  const GetTokenFromPolar({Key? key}) : super(key: key);


  @override
  TokenRequestToPolar createState() => TokenRequestToPolar();
}

class TokenRequestToPolar extends State<GetTokenFromPolar> {

  late Future<String> msg;



  Future<String> fetchAccessData(String toSend) async {
    var response = await http.post(Uri.parse('https://polarremote.com/v2/oauth2/token'),
        headers:
        {
          'Authorization': 'Basic MjFlMmY3MjAtMzgzMi00MmQ0LWI4YWQtM2Q4ZWYwMDY3MDIzOmI5ZWE3M2Q3LTAxODktNGRjZS1iYTBhLWZjZTk1YzdlYmQ3NA==',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json;charset=UTF-8'
        },
        body:
        {
          "code": toSend,
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
    msg=fetchAccessData(Provider.of<AppData>(context,listen: false).code);
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
          title: const Text('THIS IS YOUR TOKEN'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: msg,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String userId=snapshot.data!.substring(0,snapshot.data!.indexOf("B"));
                String token=snapshot.data!.substring(snapshot.data!.indexOf("B"));
                Provider.of<AppData>(context,listen: false).setToken(token);
                Provider.of<AppData>(context,listen: false).setUserId(userId);
                //TODO FIX THIS VIOLATION OF MVC ^
                print(userId);
                print(token);
                return ElevatedButton(
                    onPressed: () => BaseCommand().toClientMenuApi(context),
                    child: Text(token));



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




