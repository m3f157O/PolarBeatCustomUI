
import 'dart:convert';



import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'deserialization.dart';

class ShowData extends StatefulWidget {

  const ShowData({Key? key}) : super(key: key);


  @override
  RequestAndShow createState() => RequestAndShow();
}


class RequestAndShow extends State<ShowData> {

  late Future<List<dynamic>> msg;
  late String token;

  late Available activities;

  Future<Response> fireTransactionStartRequest(String toFetch) async {
    var response = await http.post(Uri.parse(toFetch),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );
    return response;
  }


  Future<Response> fireActivityDataRequest(String toFetch) async {
    var response = await http.get(Uri.parse(toFetch),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );
    return response;
  }

  Future<List<dynamic>> fetchActivities() async {

    token=await Controller.fetchToken();
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
        list.add("NO DATA TO DISPLAY");
        return list;
      }
      return processDailyActivities(list);

    } else {

      return [response.statusCode.toString()];

    }
  }


  Future<List<dynamic>> processDailyActivities(List<dynamic> toFetch) async {
    List<dynamic> list= [];

    if(toFetch.isNotEmpty)
    {
    for(int i=0; i<toFetch.length;i++) {
      var response = await http.get(Uri.parse(toFetch.elementAt(i)),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        Map<String, dynamic> user = jsonDecode(response.body);
        print(user);
        list.add([user['duration'],user['detailed-sport-info'],user['calories']]);

        print(list);


      }

    }
    }

    print("returning");

    return list;



  }

  @override
  void initState() {
    super.initState();

    msg=fetchActivities();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: msg,
      builder: (context, snapshot) {
        if (snapshot.hasData) {




          return ListView.builder(
            itemBuilder: (context, index){
              return ListTile(
                title: Text(snapshot.data![index][0]),
                subtitle: Text(snapshot.data![index][1]),
                leading: Icon(Icons.hourglass_empty),
                dense: true,
                tileColor: Colors.grey,
                onTap: () {
                  setState(() {

                  });
                }
              );


            },
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          );

        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }


        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );

  }

}




