/*
import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/exercise_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'graphs/graph.dart';

//TODO NULL CHECK PROPERLY

class ShowData extends StatefulWidget {

  const ShowData({Key? key}) : super(key: key);


  @override
  RequestAndShow createState() => RequestAndShow();
}


class RequestAndShow extends State<ShowData> {

  late List<Map<dynamic,dynamic>> msg;
  late List<Map<dynamic,dynamic>> msg2;
  late Map<dynamic,dynamic> msg3;

  bool waiting=false;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  void onItemTapped() {
    return;
  }

  final int _selectedIndex=1;

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    msg3 = Provider.of<AppState>(context).profile;
    msg2 = Provider.of<AppState>(context).savedActivities;
    msg = Provider.of<AppState>(context).newActivities;


    print(msg.length);
    var _selectedIndex=0;
    return Scaffold(
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
                  "Hello!",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                Text(
                  "Prateek Sharma",
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
                            "Total Balance",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Text(
                            "425,04€",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
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
                              "Balance for today",
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
                              "19,00€",
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
                              "Unlock the limit of 19£",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              "By linking your bank card",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 16, right: 16),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFF559F),
                                    Color(0xFFCF5CCF),
                                    Color(0xFFFF57AC),
                                    Color(0xFFFF6D91),
                                    Color(0xFFFF8D7E),
                                    Color(0xFFB6BAA6),
                                  ],
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
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
                              Color(0xFFFF559F),
                              Color(0xFFCF5CCF),
                              Color(0xFFFF57AC),
                              Color(0xFFFF6D91),
                              Color(0xFFFF8D7E),
                              Color(0xFFB6BAA6),
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
                              Color(0xFFFF559F),
                              Color(0xFFCF5CCF),
                              Color(0xFFFF57AC),
                              Color(0xFFFF6D91),
                              Color(0xFFFF8D7E),
                              Color(0xFFB6BAA6),
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
                              Color(0xFFFF559F),
                              Color(0xFFCF5CCF),
                              Color(0xFFFF57AC),
                              Color(0xFFFF6D91),
                              Color(0xFFFF8D7E),
                              Color(0xFFB6BAA6),
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
    );
  }
}









*/