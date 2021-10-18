

import 'dart:convert';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClientMenuAPI extends StatelessWidget {

  const ClientMenuAPI({Key? key}) : super(key: key);




  void registerUser(BuildContext context) async {
    String userToken=Provider.of<AppData>(context,listen: false).token;
    String userId=Provider.of<AppData>(context,listen: false).userid;
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
        primarySwatch: Colors.red,
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
                    onPressed: () => registerUser(context),
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

