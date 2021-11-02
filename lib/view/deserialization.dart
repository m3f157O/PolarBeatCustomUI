import 'dart:ffi';

class Available    {
  int userid;
  String activity;
  String url;

  Available(this.userid,this.activity,this.url);

  Available.fromJson(Map<String, dynamic> json)
      : userid = json['user-id'],
        activity = json['data-type'],
        url =json['url'];

}


class Profile    {
  int polaruserid;
  String polarmemberid;
  String recdate;
  String firstname;
  String lastname;
  String birthdate;
  String gender;
  double weight;
  double height;
  dynamic extrainfo;


  Profile.fromJson(Map<String, dynamic> json)
      : polaruserid = json['polar-user-id'],
        polarmemberid = json['member-id'],
        recdate =json['registration-date'],
        firstname =json['first-name'],
        lastname =json['last-name'],
        birthdate =json['birthdate'],
        gender =json['gender'],
        weight =json['weight'],
        height =json['height'],
        extrainfo =json['field'];


}
