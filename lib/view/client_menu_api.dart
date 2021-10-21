

import 'dart:convert';
import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'deserialization.dart';

class ClientMenu extends StatefulWidget {


  const ClientMenu({Key? key}) : super(key: key);


  @override
  ClientMenuAPI createState() => ClientMenuAPI();
}

class ClientMenuAPI extends State<ClientMenu> {

  late String userId;
  late String token;
  late Future<List<dynamic>> msg;
  late Future<List<dynamic>> msg2;
  late Available activities;




  Future<List<dynamic>> fireUserInfoRequest() async {
    print('https://www.polaraccesslink.com/v3/users/'+userId.substring(8));
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
      print(user['registration-date']);
      List<dynamic> userInfo=[user['registration-date'],user["first-name"],user["last-name"]];
      return userInfo;
      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode);
      print(response.contentLength);
      return ["ba4d"];
    }
  }



  @override
  void initState() {
    super.initState();
    token=Provider.of<AppData>(context,listen: false).token;
    userId=Provider.of<AppData>(context,listen: false).userid;
    msg=fireUserInfoRequest();
    msg2=fetchActivities(context);

  }


  Future<List<dynamic>> fetchActivities(BuildContext context) async {
    var response = await http.get(Uri.parse('https://www.polaraccesslink.com/v3/notifications'),
      headers:
      {
        'Authorization': 'Basic MjFlMmY3MjAtMzgzMi00MmQ0LWI4YWQtM2Q4ZWYwMDY3MDIzOmI5ZWE3M2Q3LTAxODktNGRjZS1iYTBhLWZjZTk1YzdlYmQ3NA==',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> userData = jsonDecode(response.body);
      List av=userData['available-user-data'];      // then parse the JSON.
      activities=Available.fromJson(av.elementAt(0));
      return startFetchActivityDataTransaction(activities.url);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      activities=Available(0,'dum','dum');

      print(response.statusCode);
      print(response.body);
      return startFetchActivityDataTransaction(activities.url);
    }
  }

  Future<List<dynamic>> startFetchActivityDataTransaction(String toFetch) async {

    if(toFetch=='dum') {
      return ['empty'];
    }

    var response = await http.post(Uri.parse(toFetch),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,


      Map<String, dynamic> user = jsonDecode(response.body);
      print(user);

      return getDailyActivities(user['resource-uri']);
    } else if(response.statusCode==204){

      return ['empty'];
    } else{

      return ['not ok'];
    }
  }

  Future<List<dynamic>> getDailyActivities(String toFetch) async {

    var response = await http.get(Uri.parse(toFetch),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      print(response.statusCode);
      List<dynamic> list=user["exercises"] ?? [];
      print(list);
      if(list.isEmpty) {
        list=List.empty();
        print("vuota");
      }
      return list;

    } else {

      return [response.statusCode.toString()];

    }
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
                  FutureBuilder<List<dynamic>>(
                      future: msg2,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {




                          return ListView.builder(
                            itemBuilder: (BuildContext, index){
                              return Card(
                                child: ListTile(
                                  leading: const CircleAvatar(),
                                  title: Text(snapshot.data![index].toString()),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(5),
                            scrollDirection: Axis.vertical,
                          );

                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }


                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),


                  FutureBuilder<List<dynamic>>(
                      future: msg,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {



                        if (!snapshot.data!.contains('ba4d')) {
                          return ListView.builder(
                            itemBuilder: (BuildContext, index){
                              return Card(
                                child: ListTile(
                                  leading: const CircleAvatar(),
                                  title: Text(snapshot.data![index].toString()),
                                ),
                              );
                            },
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(5),
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

