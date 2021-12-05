
import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/exercise_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'graphs/fast_iso.dart';
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
    msg2 = Provider.of<AppState>(context).savedActivities;
    msg = Provider.of<AppState>(context).newActivities;
    Color main=Provider.of<AppState>(context).main;
    Color second=Provider.of<AppState>(context).second;
    Color text=Provider.of<AppState>(context).text;

    print(msg.length);
    var _selectedIndex=0;
    return Scaffold(
      backgroundColor: main,
      body: Container(
        color: main,
        child: Stack(
          children: [





            Container(
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      LiquidPullToRefresh(
                        color: Colors.black54,
                        backgroundColor: Colors.black54,
                        springAnimationDurationInMilliseconds: 500,
                        showChildOpacityTransition: false,
                        onRefresh: () async {
                          setState(() {
                            Controller().refreshActivities(context);
                            Controller().statsRoutine(context);
                          });
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            SizedBox(
                              // color: Colors.red,
                              height: 300,

                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController2,
                                  itemCount: msg2.length,
                                  itemBuilder: (context, i) {
                                    if (i == msg2.length) {
                                      return  CupertinoActivityIndicator();
                                    }
                                    return Bounceable(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ExerciseView(msg2.elementAt(i))));
                                      },
                                      child: Container(
                                        height: 80,
                                        width: double.infinity,
                                        padding:  EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        margin:  EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          color: second,
                                        ),
                                        child: Row(

                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             SizedBox(width: 5),


                                            Expanded(child :Text(
                                              DateTime.parse(msg2.elementAt(i).entries.elementAt(5).value).toString().substring(0,22),
                                              style:  TextStyle(color: text,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            )),



                                            Expanded(child :Column(
                                              children: [
                                                Text(
                                                  toDuration(msg2.elementAt(i)["duration"]).toString().substring(0,10),
                                                  style:  TextStyle(
                                                      color: text,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                ),

                                                Expanded(child :Text(
                                                  "   " + msg2.elementAt(i)['sport'].toString(),
                                                  style:  TextStyle(color: text,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                )),



                                              ],
                                            )),

                                            Expanded(child :Column(
                                              children: [
                                                Text(
                                                  "Average:" +msg2.elementAt(i)['average'].toString(),
                                                  style:  TextStyle(
                                                      color: text,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "High:" + msg2.elementAt(i)['maximum'].toString(),
                                                  style:  TextStyle(
                                                      color: text,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "Calories:" +msg2.elementAt(i)['calories'].toString(),
                                                  style:  TextStyle(
                                                      color: text,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Spacer(),



                                              ],
                                            )),



                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 30,
                                  margin:  EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        second,
                                        main,
                                      ]),

                                    )
                                ),

                              ),


                        SizedBox(
                          // color: Colors.red,
                          height: 300,

                          child: ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController2,
                              itemCount: msg.length,
                              itemBuilder: (context, i) {
                                if (i == msg.length) {
                                  return  CupertinoActivityIndicator();
                                }
                                return Bounceable(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ExerciseView(msg.elementAt(i))));
                                  },
                                  child: Container(
                                    height: 80,
                                    width: double.infinity,
                                    padding:  EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    margin:  EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: main,
                                    ),
                                    child: Row(

                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         SizedBox(width: 5),

                                        Expanded(child :Text(
                                          msg.elementAt(i).entries.elementAt(5).value,
                                          style:  TextStyle(color: second,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )),

                                        Expanded(child :Text(
                                          "   " + msg.elementAt(i)['sport'].toString(),
                                          style:  TextStyle(color: second,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        )),



                                        Expanded(child :Column(
                                          children: [
                                            Text(
                                              "Average:" +msg.elementAt(i)['average'].toString(),
                                              style:  TextStyle(
                                                  color: second,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              "High:" + msg.elementAt(i)['maximum'].toString(),
                                              style:  TextStyle(
                                                  color: second,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Calories:" +msg.elementAt(i)['calories'].toString(),
                                              style:  TextStyle(
                                                  color: second,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Spacer(),



                                          ],
                                        )),



                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),


                          ],
                        )

                      ),
                    ]),
                  ),

                ],
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



}





