

import 'dart:convert';
import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/db_model.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'deserialization.dart';


class ClientMenu extends StatefulWidget {


  const ClientMenu({Key? key}) : super(key: key);


  @override
  ClientMenuAPI createState() => ClientMenuAPI();
}

class ClientMenuAPI extends State<ClientMenu> {


  late Future<List<dynamic>> _msg;




  Future<List<dynamic>> fireUserInfoRequest() async {

    String token= await Controller().fetchToken();
    String userId=await Controller().fetchId();

    //print('https://www.polaraccesslink.com/v3/users/'+userId.substring(8));


    var response = await http.get(Uri.parse('https://www.polaraccesslink.com/v3/users/'+userId.substring(8)),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      Profile cicheck=Profile.fromJson(user);


      //DataBase().createProfileTable();
      Controller().depositProfile(cicheck);
      List<dynamic> userInfo=[user['registration-date'],user["first-name"],user["last-name"]];

      return userInfo;

      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //print(response.statusCode);
      //print(response.contentLength);
      return ["ba4d"];
    }
  }



  @override
  void initState() {
    super.initState();
    _msg=fireUserInfoRequest();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BASIC CLIENT MENU',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('BASIC CLIENT MENU'),
          ),
          body: Center(

              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  const ShowData(),


                  FutureBuilder<List<dynamic>>(
                      future: _msg,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {



                        if (!snapshot.data!.contains('ba4d')) {
                          return ListView.builder(
                            itemBuilder: (context, index){
                              return Card(
                                child: ListTile(
                                  leading: const CircleAvatar(),
                                  title: Text(snapshot.data![index].toString()),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            scrollDirection: Axis.vertical,
                          );
                        }
                        else {
                          return Text(snapshot.data!.first);
                        }

                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }


                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                ],
              )
          )
      ),

    );
  }
}

