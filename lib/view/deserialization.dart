
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


/*
class Exercise    {
  String id;
  String upload_time;
  String polar_user;
  String device;
  String start_time;
  int start_time_utc_offset;
  String duration;
  double calories;
  double distance;
  Map<String,int> heart_rate;
  double training_load;
  String sport;
  bool has_route;
  String club_id;
  String club_name;
  String detailed_sport_info;
  String fat_percentage;
  String carbohydrate_percentage;
  String protein_percentage;


  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        upload_time = json['upload_time'],
        polar_user =json['polar_user'],
        device =json['device'],
        lastname =json['last-name'],
        birthdate =json['birthdate'],
        gender =json['gender'],
        weight =json['weight'],
        height =json['height'],
        extrainfo =json['field'];


}

*/
