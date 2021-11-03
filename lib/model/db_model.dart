import 'dart:convert';

import 'package:custom_polar_beat_ui_v2/view/deserialization.dart';
import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'package:synchronized/extension.dart';

//TODO FATAL MAKE DB CHECK WETHER TABLES EXIST DURING INIT



class DataBase {

    static late final Database _database;

    static const _databaseName = "/my_db";


    Future<bool> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath+_databaseName;
    print(path);
    _database = await openDatabase(path);
    return true;
  }
    Future<Database> get database async {
    return _database;
    }


     void updateTokenTable(String type,String token) async {
      Map<String,String> map={ "type":type,"name":token };
      // List<Map> result = await db.query("Tokens");

      await _database.insert("Tokens",map);
      var result = await _database.query("Tokens");
      print(result);
      print("database after "+type+" storage");
    }


    void updateProfileTable(Profile profile) async {
      // List<Map> result = await db.query("Tokens");


      Map<String,Object> toPass={
        "polaruserid":profile.polaruserid,
        "recdate":profile.firstname,
        "firstname":profile.firstname,
        "lastname":profile.lastname,
        "birthdate":profile.birthdate,
        "gender":profile.gender,

      };

      print(profile);
      await _database.insert("Profile",toPass);
      var result = await _database.query("Profile");
      print(result);
      print("database after storage");
    }

    void dropTokenTable() async {

      _database.execute('DROP TABLE Tokens');


    }
    void dropProfileTable() async {

      _database.execute('DROP TABLE Profile');


    }

     void reset() async {

       synchronized(() async {
         dropTokenTable();
       });
       synchronized(() async {
         createTokenTable();
       });
       synchronized(() async {
         dropProfileTable();
       });
       synchronized(() async {
         createProfileTable();
       });
    }

    void createTokenTable() async {


      _database.execute(
          'CREATE TABLE Tokens (type TEXT, name TEXT)');


    }

    void createProfileTable() async {


      _database.execute(
          'CREATE TABLE Profile (polaruserid INT, recdate TEXT, firstname TEXT, lastname TEXT, birthdate TEXT, gender TEXT)');

    }


    /// HARDCODING HERE IS NECESSARY BECAUSE
    /// I DON'T WANT TO USE SQL HELPERS
     Future<String> fetchToken() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='bearer'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }

    Future<Map<dynamic,dynamic>> fetchProfile() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Profile");

      if(list.isEmpty) {
        return {};
      } else {

        print(list.length);

        return list.elementAt(0);
      }
    }

     Future<String> fetchId() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='id'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }

     Future<String> fetchCode() async {

      List<Map> list = await _database.rawQuery("SELECT * FROM Tokens WHERE type='code'");

      if(list.isEmpty) {
        return "";
      } else {

        return list.elementAt(0)["name"];
      }
    }

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

      print("called");

      String temp= await fetchToken();
      String temp2= await fetchId();
      String code=await fetchCode();

      if(temp2.isNotEmpty) {
        print("loading token from sqflite");
        return temp2+temp;
      }

      var response = await fireTokenDataRequest(code);
      if (response.statusCode == 200) {

        Map<String, dynamic> user = jsonDecode(response.body);



        String token= "Bearer " + user['access_token'];
        String id="User_id_"+user['x_user_id'].toString();
        //print(user);

        // Controller.updateToken(token);


        updateTokenTable("bearer",token);
        updateTokenTable("id",id);
        print("fetching data from Polar");

        return id+token.toString(); //really don't want to use a list, I'd rather parse the whole string
      } else {


        return response.statusCode.toString();
      }
    }

    Future<void> registerUser() async {

      String token=await fetchToken();
      String id=await fetchId();

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
        Map<String, dynamic> user = jsonDecode(response.body);
        //print(user['registration-date']);
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


    Future<Map<String,Object>> fireUserInfoRequest() async {


      String token= await fetchToken();
      String userId=await fetchId();
      var temp=await fetchProfile();
      if(temp.isNotEmpty) {
        print("loading profile from sqflite");
        return Map.from(temp);
      }

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

        //TODO REMOVE DESERIALIZATION CLASS ( MORE MARSHALLING)
        Map<String,Object> toRet=Map.from(user);

        Profile toUpdate=Profile.fromJson(user);
        toRet.remove('polarmemberid');
        toRet.remove('weight');
        toRet.remove('height');
        toRet.remove('extra-info');
        updateProfileTable(toUpdate);
        //DataBase().createProfileTable();

        List<dynamic> userInfo=[user['registration-date'],user["first-name"],user["last-name"]];

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



    Future<List<Map<String,Object>>> fetchActivities() async {

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
        Available activities=Available.fromJson(av.elementAt(0));
        return startFetchActivityDataTransaction(activities.url);
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.

        print(response.statusCode);
        print(response.body);
        return [];
      }
    }

    Future<List<Map<String,Object>>> startFetchActivityDataTransaction(String toFetch) async {

      String token=await fetchToken();

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

        return [{}];
      } else{

        return [{}];
      }
    }

    Future<List<Map<String,Object>>> getDailyActivities(String toFetch) async {

      String token=await fetchToken();

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
        print(user["exercises"].runtimeType);
        List<dynamic> list=user["exercises"] ?? [];
        if(list.isEmpty) {
          print("returning empty list");
          return [{}];
        }
        return processDailyActivities(list);

      } else {

        return [{}];

      }
    }


    Future<List<Map<String,Object>>> processDailyActivities(List<dynamic> toFetch) async {
      List<Map<String,Object>> list= [];
      String token=await fetchToken();

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

            Map<String,Object> map=Map.from(user);
            list.add(map);

            print(list);
            print("list after element");


          }

        }
      }

      print("returning");

      return list;



    }



}