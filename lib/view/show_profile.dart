import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    Map msg3 = Provider.of<AppState>(context).profile;
    int cal=Provider.of<AppState>(context).totalCalories;
    int dis=Provider.of<AppState>(context).totalDistance;
    Duration dur=Provider.of<AppState>(context).totalTime;
    Color main=Provider.of<AppState>(context).main;
    Color second=Provider.of<AppState>(context).second;
    int localCalories=Provider.of<AppState>(context).localCalories;
    int localDistance=Provider.of<AppState>(context).localDistance;
    Color text=Provider.of<AppState>(context).text;

    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [


            Scaffold(
              backgroundColor: main,
                      body: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "Hello! ",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        Text(
                          msg3["firstname"].toString()=='empty' ? msg3["firstname"].toString() : " " + " "+ msg3["lastname"].toString()=='empty' ? msg3["lastname"].toString() : " ",
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: Container(
                            height: 300,

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Total energy",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: second),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    cal.toString()+" cal",
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: second),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Total Distance",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: second),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    dis.toString()+" kilometers",
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: second),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16,
                                    top: 16,
                                  ),
                                  child: Text(
                                    "Total Time",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: second),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    dur.inMinutes.toString()+ " minutes",
                                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: second),
                                  ),
                                ),



                              ],
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      right: 16,
                                      top: 16,
                                    ),
                                    child: Text(
                                      "Distance for today",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Text(
                                      localCalories.toString(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 16,
                                      left: 16,
                                      right: 16,
                                    ),
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16.0,
                                      right: 16,
                                      top: 16,
                                    ),
                                    child: Text(
                                      "Calories for today",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Text(
                                      localDistance.toString(),
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "March 2020",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "-52,30£",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w900,
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                      second,
                                      main
                                    ]).createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                  child: Icon(
                                    Icons.local_pizza,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ),
                              title: Text(
                                "Sc Boul Andre",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              subtitle: Text(
                                "12 March 13:43",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              trailing: Text("-9.20£",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  )),
                            ),
                            ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                      second,
                                      main
                                    ]).createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                  child: Icon(
                                    Icons.local_pizza,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ),
                              title: Text(
                                "Sc Boul Andre",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              subtitle: Text(
                                "12 March 13:43",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              trailing: Text("-9.20£",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  )),
                            ),
                            ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                      second,
                                      main
                                    ]).createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                  child: Icon(
                                    Icons.local_pizza,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              ),
                              title: Text(
                                "Sc Boul Andre",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              subtitle: Text(
                                "12 March 13:43",
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              trailing: Text("-9.20£",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    ),
    ),


            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        stops: [0,1],
                        colors: [
                          second,
                          main
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    )
                ),

              ),
            ),


          ],
        ),
      ),
    );
  }

  void onStartButtonPressed() {

  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }
}