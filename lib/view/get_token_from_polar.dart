
import 'dart:convert';

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class GetTokenFromPolar extends StatefulWidget {

  const GetTokenFromPolar({Key? key}) : super(key: key);


  @override
  TokenRequestToPolar createState() => TokenRequestToPolar();
}


class TokenRequestToPolar extends State<GetTokenFromPolar> {

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


  Future<String> fetchAccessToken() async {



    String temp= await Controller().fetchToken();
    String temp2= await Controller().fetchId();
    String code=await Controller().fetchCode();

    if(temp2.isNotEmpty) {
      print("loading data from sqflite");
      return temp2+temp;
    }

    var response = await fireTokenDataRequest(code);
    if (response.statusCode == 200) {

      Map<String, dynamic> user = jsonDecode(response.body);



      String token= "Bearer " + user['access_token'];
      String id="User_id_"+user['x_user_id'].toString();
      print(user);

     // Controller.updateToken(token);


      Controller().updateToken(token);
      Controller().updateId(id);
      print("fetching data from Polar");

      // evil string hack, the B is always there
      return id+token.toString(); //really don't want to use a list, I'd rather parse the whole string
    } else {


      return response.statusCode.toString();
    }
  }


  Future<void> registerUser(String token, String userId) async {

    var response = await http.post(Uri.parse('https://www.polaraccesslink.com/v3/users'),
        headers:
        {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token
        },
        body:
        jsonEncode({"member-id": userId})
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      print(user['registration-date']);
      // then parse the JSON.
      return ;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode.toString());
      print(response.contentLength);

      return;
    }
  }


  @override
  void initState() {
    super.initState();

    msg=fetchAccessToken();

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
                registerUser(token,userId);



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




