
import 'dart:convert';

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart'; //TODO <---this is bad


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class getTokenFromPolar extends StatefulWidget {

  const getTokenFromPolar({Key? key}) : super(key: key);


  @override
  TokenRequestToPolar createState() => TokenRequestToPolar();
}


class TokenRequestToPolar extends State<getTokenFromPolar> {

  late Future<String> msg;

  Future<Response> fireTokenDataRequest(String toSend) async {

    return await http.post(Uri.parse('https://polarremote.com/v2/oauth2/token'),
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
  }





  Future<String> fetchAccessToken(String toSend) async {

    var response = await fireTokenDataRequest(toSend);
    if (response.statusCode == 200) {

      Map<String, dynamic> user = jsonDecode(response.body);


      String token= "Bearer " + user['access_token'];
      String id="User_id_"+user['x_user_id'].toString();


      // evil string hack, the B is always there
      return id+token.toString(); //really don't want to use a list, I'd rather parse the whole string
    } else {


      return response.statusCode.toString();
    }
  }





  @override
  void initState() {
    super.initState();
    msg=fetchAccessToken(Provider.of<AppData>(context,listen: false).code);
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
                String userId=snapshot.data!.split('B')[0];
                String token='B'+snapshot.data!.split('B')[1];
                //I look for the B, which is always present. This is fast
                print(userId);
                print(token);

                Controller.setAuthAndToken(context,token,userId);



                return ElevatedButton(
                    onPressed: () => Controller().toViewMenu(context),
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




