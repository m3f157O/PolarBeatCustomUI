


import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetController {


  late final String _token;

  void setToken(String value) {
    _token = value;
  }

  void setId(String value) {
    _id = value;
  }

  late final String _id;

  Future<Map<String,Object>> userProfileRequest(String token,String userId) async {

    var response= await http.get(Uri.parse('https://www.polaraccesslink.com/v3/users/'+userId.substring(8)),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);

      //TODO REMOVE DESERIALIZATION CLASS ( MORE MARSHALLING)
      Map<String,Object> toRet=Map.from(user);

      toRet.remove('member-id');
      toRet.remove('weight');
      toRet.remove('height');
      toRet.remove('extra-info');




      //DataBase().createProfileTable();


      return toRet;

      // then parse the JSON.
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      //print(response.statusCode);
      //print(response.contentLength);
      return {};
    }
  }


  Future<List<Map<String,Object>>> fetchNotifications(String token) async {

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

      return startFetchActivityDataTransaction(av.elementAt(0)['url'],token);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

      print(response.statusCode);
      print(response.body);
      return [];
    }

  }

  Future<List<Map<String,Object>>> startFetchActivityDataTransaction(String toFetch,String token) async {

    print("Initiating Transaction");


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
      return getDailyActivities(user['resource-uri'],token);
    } else if(response.statusCode==204){

      return [];
    } else{

      return [];
    }
  }



  Future<List<Map<String,Object>>> getDailyActivities(String toFetch,String token) async {
    Response response;
    print("Getting list of notifications");
    try{
      response = await http.get(Uri.parse(toFetch),
        headers:
        {
          'Authorization': token,
          'Accept': 'application/json'
        },
      );
    }
    on TimeoutException catch (e) {
      print("Connection timeout");
      return [];
    }


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      Map<String, dynamic> user = jsonDecode(response.body);
      print(response.statusCode);
      List<dynamic> list=user["exercises"] ?? [];
      if(list.isEmpty) {
        print("returning empty list");
        return [];
      }
      return processDailyActivities(list,token);

    } else {

      return [];

    }
  }



  Future<List<Map<String,Object>>> processDailyActivities(List<dynamic> toFetch,String token) async {
    List<Map<String,Object>> list= [];

    if(toFetch.isNotEmpty)
    {
      for(int i=0; i<toFetch.length;i++) {
        print("processing activity number "+ i.toString());

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

          Map<String,Object> map=Map.from(user);
          print("deserializing map");
          print(list);
          print(map);
          Map<String, dynamic>? dynamicMap=(map['heart-rate'] ?? {}) as Map<String, dynamic>?;
          print("questo è il tuo heart rate");
          map.remove('heart-rate');
          if(map.isEmpty) {
            return list;
          }

          Map<String,Object> transformedMap = map.map((k, v) {
            return MapEntry(k.replaceAll("-", ""), v);
          });

          Map<String,Object> transformedHRmap = dynamicMap!.map((k, v) {
            return MapEntry(k.replaceAll("-", ""), v);
          });

          print(transformedHRmap);

          list.add(transformedMap);

          print("list after element");


        }

      }
    }

    print("returning");

    return list;



  }


  Future<bool> registerUser(String token,String id) async {

    var response = await http.post(Uri.parse('https://www.polaraccesslink.com/v3/users'),
        headers:
        {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token
        },
        body:
        jsonEncode({"member-id": id})
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      //print(user['registration-date']);
      // then parse the JSON.
      return true;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print(response.statusCode.toString());
      print(response.contentLength);

      return false;
    }
  }

  Future<String> fireTokenDataRequest(String toSend) async {

    var response= await http.post(Uri.parse('https://polarremote.com/v2/oauth2/token'),
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

      Map<String, dynamic> user = jsonDecode(response.body);



      String token= "Bearer " + user['access_token'];
      String id="User_id_"+user['x_user_id'].toString();
      //print(user);

      // Controller.updateToken(token);


      print("fetching data from Polar");

      setToken(token);
      setId(id);
      return id+token.toString(); //really don't want to use a list, I'd rather parse the whole string
    } else {


      return response.statusCode.toString();
    }

  }






}

