


import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';



class NetController {


  //TODO USE THIS IF YOU WANT
  // most of API calls are hardcoded because expandability would be very low anyway
  late final String _token;
  late final String _id;
  void setToken(String value) {_token = value;}
  void setId(String value) {_id = value;}



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

      print("fetching data from Polar");

      setToken(token);
      setId(id);

      return id+token.toString(); //really don't want to use a list, I'd rather parse the whole string
    } else {


      return response.statusCode.toString();
    }

  }



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
      Map<String,Object> toRet=Map.from(user);

      toRet.remove('member-id');
      toRet.remove('weight');
      toRet.remove('height');
      toRet.remove('extra-info');

      return toRet;
    } else {

      return {};
    }
  }


  Future<String> fetchNotifications(String token) async {

    var response = await http.get(Uri.parse('https://www.polaraccesslink.com/v3/notifications'),
      headers:
      {
        'Authorization': 'Basic MjFlMmY3MjAtMzgzMi00MmQ0LWI4YWQtM2Q4ZWYwMDY3MDIzOmI5ZWE3M2Q3LTAxODktNGRjZS1iYTBhLWZjZTk1YzdlYmQ3NA==',
        'Accept': 'application/json',
      },
    );


    if (response.statusCode == 200) {

      Map<String, dynamic> userData = jsonDecode(response.body);
      List av=userData['available-user-data'];      // then parse the JSON.
      return av.elementAt(0)['url'];
    } else {
      print(response.statusCode);
      print(response.body);
      return '';
    }

  }

  Future<String> startFetchActivityDataTransaction(String toFetch,String token) async {


    if(toFetch.isEmpty) {
      print("No new notifications");

      return '';
    }
    print("Initiating Transaction");
    var response = await http.post(Uri.parse(toFetch),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 201) {

      Map<String, dynamic> user = jsonDecode(response.body);
      return user['resource-uri'];
    } else if(response.statusCode==204){
      print(response.statusCode);

      print(response.body);
      return '';
    } else{
      print(response.statusCode);

      return '';
    }
  }



  Future<List<Map<String,Object>>> getDailyActivities(String toFetch,String token) async {

    if(toFetch.isEmpty) {
      return [];
    }
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
      return processDailyActivities(list, token);

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
          print("Deserializing map");
          if(map.isEmpty) {
            return list;
          }

          Map<String, dynamic> dynamicMap=(map['heart-rate'] ?? {}) as Map<String, dynamic>;
          print("Deserializing heart rate");
          map.remove('heart-rate');
          //todo hazard
          if(dynamicMap.isNotEmpty) {
            map.addAll({"average":dynamicMap["average"],"maximum":dynamicMap["maximum"]});
          }

          print(map['has-route']);
          print("Checking for GPX existence");
          bool temp=map['has-route']==true ? true : false;
          map.remove(["has-route"]);
          if(temp) {
            print("This one has gps");
            String gpx=await getExerciseGPX(toFetch.elementAt(i)+"/gpx", token);
            map.addAll({"gpx":gpx});
            map.addAll({"hasroute":1});

          }
          else {
            map.addAll({"hasroute":0});
          }

          String toPut=await getExerciseZones(toFetch.elementAt(i)+"/heart-rate-zones", token);
          map.addAll({"zones":toPut});
          print("Getting samples from activity"+i.toString());
          toPut=await getExerciseSamples(toFetch.elementAt(i)+"/samples", token);

          Map<String,Object> transformedMap = map.map((k, v) {
          return MapEntry(k.replaceAll("-", ""), v);
          });



          list.add(transformedMap);

          print("thats the new map");
          transformedMap.addAll({"samples":toPut});
          print(transformedMap);


        }

      }
    }

    print("Ending activity processing");


    return list;



  }



  Future<String> getExerciseSamples(String toFetch,String token) async {
    List<Map<String,Object>> list= [];
    List<Map<String,Object>> temp= [];
    var response = await http.get(Uri.parse(toFetch),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Acquiring sample list");
      Map<String, dynamic> user = jsonDecode(response.body);

      List<dynamic> data=user["samples"] ?? [];



      return await processExercisesSample(data,token);


    }
    else {
      print("No sample");
      print(response.statusCode);

      Map<String, dynamic> user = jsonDecode(response.body);
      print(user);

    }



    return '';



  }



  Future<String> processExercisesSample(List<dynamic> toFetch,String token) async {
    List<Map<String,Object>> list= [];

    print("Processing samples");
    print(toFetch);

    if(toFetch.isNotEmpty)
    {
      for(int i=0; i<toFetch.length;i++) {
        print("Processing sample number "+ i.toString());

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
          list.add(Map.from(user));

        }
        else {
          Map<String, dynamic> user = jsonDecode(response.body);
          print(user);

        }

      }
    }

    print("returning");

    return base64.encode(utf8.encode(jsonEncode(list)));



  }



  Future<String> getExerciseGPX(String toFetch,String token) async {
    List<Map<String,Object>> list= [];

    var response = await http.get(Uri.parse(toFetch),
          headers:
          {
            'Authorization': token,
            'Accept': 'application/gpx+xml'
          },
        );

        if (response.statusCode == 200) {
          print("gpx");


        }
        else {
          print("gpx");
          print(response.statusCode);

          Map<String, dynamic> user = jsonDecode(response.body);
          print(user);

        }



    return base64.encode(utf8.encode(jsonEncode(list)));



  }





  Future<String> getExerciseZones(String toFetch,String token) async {
    List<Map<String,Object>> list= [];
    var stringBytes;
    var response = await http.get(Uri.parse(toFetch),
      headers:
      {
        'Authorization': token,
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Acquiring heart rate zones");

      Map<String, dynamic> user = jsonDecode(response.body);
      List<dynamic> list=user["zone"] ?? [];

      print(list);
      stringBytes = base64.encode(utf8.encode(jsonEncode(list)));

    //  Map<String,dynamic> cane=jsonDecode(utf8.decode(base64.decode(stringBytes)));

      print(stringBytes);
    }

    print("returning");

    return stringBytes;



  }


  Future<List<Map<String,Object>>> exerciseCoordinator(String token) async {


    return await getDailyActivities(await startFetchActivityDataTransaction(await fetchNotifications(token),token),token);

  }




}

