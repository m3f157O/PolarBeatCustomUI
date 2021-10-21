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
