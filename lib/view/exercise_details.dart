import 'package:custom_polar_beat_ui_v2/view/graphs/heartbeat_graph.dart';
import 'package:custom_polar_beat_ui_v2/view/graphs/zones_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'graphs/fast_iso.dart';

class ExerciseDetails extends StatelessWidget {


  const ExerciseDetails({Key? key, required this.data, required this.color, required this.second}) : super(key: key);



  final Map data;
  final Color color;
  final Color second;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(
                  height: 76,
                ),


                const SizedBox(height: 25),
                SizedBox(
                  height: 279,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(width: 28),
                      const SizedBox(width: 20),
                      Container(
                        height: 280,
                        width: 280,
                        decoration: BoxDecoration(
                          color: color,

                        ),
                        child: ShowHeartbeat(data: data, color: second, title: ""),
                      ),
                      Container(
                        height: 280,
                        width: 280,
                        decoration: BoxDecoration(
                          color: color,

                        ),
                        child: HistogramDefault(data: data),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(child :Container(

                      child: Text("Duration: " + toDuration(data["duration"]).toString().substring(0,7),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),

                    )),
                    const SizedBox(width: 16),

                  ],
                ),
                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(child :Container(

                      child: Text("kCalories: "+data["calories"].toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),

                    )),
                    const SizedBox(width: 16),
                    Expanded(child :Container(

                      child: const Text("",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),

                    )),
                  ],
                ),
                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(child :Container(

                      child: Text(data["maximum"].toString()=='null' ? "" : "top HR: "+data["maximum"].toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),

                    )),
                    const SizedBox(width: 16),
                    Expanded(child :Container(

                      child: Text(data["average"].toString()=='null' ? "" : "avg HR: "+data["average"].toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),

                    )),
                  ],
                ),
                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(child :Container(

                      child: Text("Distance: "+data["distance"].toString()+" meters",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),

                    )),
                    const SizedBox(width: 16),

                  ],
                ),
                const SizedBox(height: 32),

                Row(
                  children: [

                    Expanded(child :Container(


                      child: Text("Start Time: "+DateTime.parse(data["starttime"]).toString().substring(0,19),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                      ),

                    )),
                  ],
                ),
                const SizedBox(height: 46),

              ],
            ),

            Align(alignment: Alignment.topCenter,
                child:   Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      gradient: LinearGradient(
                          stops: const [0,1],
                          colors: [
                            second,
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 22,
                        right: 22,
                        top: 20,
                        bottom: 10
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [






                        ],
                      ),
                    ),
                  ),
                )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 87,
                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        stops: const [0,1],
                        colors: [
                          second,
                          Colors.transparent,
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

  void onBackIconTapped() {
  }


}