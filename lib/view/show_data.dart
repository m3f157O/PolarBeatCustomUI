
import 'dart:convert';

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart'; //TODO <---this is bad


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ShowData extends StatefulWidget {

  const ShowData({Key? key}) : super(key: key);


  @override
  RequestAndShow createState() => RequestAndShow();
}


class RequestAndShow extends State<ShowData> {

  late Future<List<dynamic>> msg;
  late String token;

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

    Future<List<dynamic>> startFetchActivityDataTransaction(String toFetch) async {

    if(toFetch=='dum') {
      return ['empty'];
    }

      var response = await fireTransactionStartRequest(toFetch);


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

    var response = await fireActivityDataRequest(toFetch);



    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      print(response.statusCode);
      List<dynamic> list=user["exercises"];
      print(list);
      if(list.isEmpty) {
        list.add('empty');
      }
      return list;

    } else {

      return [response.statusCode.toString()];

    }
  }


  @override
  void initState() {
    super.initState();

    token=Provider.of<AppData>(context,listen: false).token;
    msg=startFetchActivityDataTransaction(Provider.of<AppData>(context,listen: false).userData.url);
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
            future: msg,
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
          );

  }

}




