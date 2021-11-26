



import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/exercise_view.dart';
import 'package:custom_polar_beat_ui_v2/view/show_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

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

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFAA6EF),
                    Color(0x00B30000),
                  ],
                  begin: FractionalOffset(0.0, 1.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.6, 2],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),




            Container(
              padding: const EdgeInsets.only(top: 70),
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      LiquidPullToRefresh(
                        color: Colors.transparent,
                        backgroundColor: Colors.black54,
                        springAnimationDurationInMilliseconds: 500,
                        showChildOpacityTransition: false,
                        onRefresh: () async {
                          setState(() {
                            print("bamboccione");
                          });
                        },
                        child: Column(
                          children: [
                            SizedBox(
                            // color: Colors.red,
                            height: 300,
                            child: ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController2,
                                itemCount: msg2.length,
                                itemBuilder: (context, i) {
                                  if (i == msg2.length) {
                                    return const CupertinoActivityIndicator();
                                  }
                                  return Bounceable(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ExerciseView(msg2.elementAt(i))));
                                    },
                                    child: Container(
                                      // color: Colors.blue,
                                      height: 75,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 30,
                                            color: Colors.black38,
                                            child: Center(
                                              child: Text(
                                                "${i + 1}",
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              // height: 50,
                                              padding:
                                              EdgeInsets.symmetric(
                                                  vertical: 5,
                                                  horizontal: 10),
                                              // margin: EdgeInsets.symmetric(vertical: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white24),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  const SizedBox(width: 5),
                                                  Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(msg2.elementAt(i).entries.elementAt(5).value),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  SizedBox(
                                                    width: 80,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            "Calories:" +msg2.elementAt(i)['calories'].toString(),
                                                            style: const TextStyle(
                                                                fontSize:
                                                                13.5),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 3),
                                                        Row(
                                                          children: [
                                                            const Text("High",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    8)),
                                                            Spacer(),
                                                            Text(
                                                              msg2.elementAt(i)['maximum'].toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  9,
                                                                  color: Colors
                                                                      .green),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text("Average",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    8)),
                                                            Spacer(),
                                                            Text(
                                                              msg2.elementAt(i)['average'].toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  9,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            ),
                            SizedBox(
                              // color: Colors.red,
                              height: 300,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _scrollController,
                                  itemCount: msg.length,
                                  itemBuilder: (context, i) {
                                    if (i == msg.length) {
                                      return const CupertinoActivityIndicator();
                                    }
                                    return Bounceable(
                                      onTap: () {
                                        print("${msg.elementAt(i).entries.first}");
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(SnackBar(
                                        //         content: Text(
                                        //             "${msg[i]['id']} is tapped")));
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ExerciseView(msg.elementAt(i))));
                                      },
                                      child: Container(
                                        // color: Colors.blue,
                                        height: 75,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                // height: 50,
                                                padding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 10),
                                                // margin: EdgeInsets.symmetric(vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white24),
                                              ),
                                            ),
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
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: const [
                          Text("Developed by Gianmarco Lodari",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12)),
                          Text(
                            "Powered by Polar API",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }



}





