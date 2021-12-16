
import 'dart:convert';

import 'package:custom_polar_beat_ui_v2/view/graphs/heartbeat_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseView extends StatelessWidget {

  final Map data;
  List<ChartData> heartBeat=[];
  List<ChartData> heartZones=[];
  ExerciseView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print(jsonDecode(utf8.decode(base64.decode(data["zones"]))).toString());

    List<dynamic> cane=jsonDecode(utf8.decode(base64.decode(data["zones"])));
    for(int i=0;i<cane.length;i++) {
      print(cane.elementAt(i));
      for(int k=0;k<10;k++) {
        heartZones.add(ChartData(cane.elementAt(i)['lower-limit'],i*10+k));
        print(heartZones.first.value);

      }
    }
    
    return MaterialApp(
        title: 'Exercise view',
        home: Scaffold(

            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    Text("Duration "+data["duration"]),
                    Text(data["gpx"] ?? "No gps data"),

                    Text("Calories "+data["calories"].toString()),

                    Text(data["average"].toString()=='null' ? "" : "avg HR: "+data["average"].toString()),
                    Text(data["maximum"].toString()=='null' ? "" : "top HR: "+data["maximum"].toString()),
                    //todo hazard
                    Expanded(child: ShowHeartbeat(data: data, color: Colors.green, title: "ciao")),

                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("back")),



                  ],
                )),
                Expanded(child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                    Text("Device "+data["device"]),
                    Text("Distance "+data["distance"].toString()),
                    Text("Start Time "+data["starttime"]),
                    //todo hazard

                    Expanded(child: ShowHeartbeat(data: data, color: Colors.green, title: "bruh")),

                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("back")),



                  ],
                ))
              ],
            )

        )

    );
  }

}



