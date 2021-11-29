
import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/exercise_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
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


    print(msg.length);
    var _selectedIndex=0;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0x00000000),
                    Color(0xFFFFFFFF),
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
                                      height: 160.0,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      child: Row(

                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(width: 5),

                                          Expanded(child :Text(
                                            msg2.elementAt(i).entries.elementAt(5).value,
                                            style: const TextStyle(color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )),
                                          Expanded(child :Text(
                                            msg2.elementAt(i).entries.elementAt(5).value,
                                            style: const TextStyle(color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )),


                                      Expanded(child :Column(
                                              children: [
                                                Text(
                                                  "Average:" +msg2.elementAt(i)['average'].toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "High:" + msg2.elementAt(i)['maximum'].toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Spacer(),
                                                Text(
                                                  "Calories:" +msg2.elementAt(i)['calories'].toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
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
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ExerciseView(msg2.elementAt(i))));
                                      },
                                      child: Container(
                                         color: Colors.blue,
                                        height: 300,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 2),
                                        child: Row(
                                          children: [
                                              Container(
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
                                                    Text(msg2.elementAt(i).entries.elementAt(5).value),
                                                    SizedBox(
                                                      width: 200,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "Calories:" +msg2.elementAt(i)['calories'].toString(),
                                                              style: const TextStyle(
                                                                  fontSize:
                                                                  13.5),
                                                            ),
                                                          ),
                                                          const Text("High",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  8)),
                                                          Spacer(),
                                                          Text(
                                                            msg2.elementAt(i)['maximum'].toString(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                20,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text("Average",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  8)),
                                                          Spacer(),
                                                          Text(
                                                            msg2.elementAt(i)['average'].toString(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                20,
                                                                color: Colors
                                                                    .red),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ],
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





