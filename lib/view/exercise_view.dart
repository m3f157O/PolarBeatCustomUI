
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseView extends StatelessWidget {

  final Map data;
  const ExerciseView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auth0 2',
        home: Scaffold(

            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [

                    Text("Duration "+data["duration"]),
                    Text(data["gpx"] ?? "No gps data"),

                    Text("Calories "+data["calories"].toString()),
                    Text("Device "+data["device"]),
                    Text("Distance "+data["distance"].toString()),
                    Text("Start Time "+data["starttime"]),
                    Text(data["average"].toString()=='null' ? "" : "avg HR: "+data["average"].toString()),
                    Text(data["maximum"].toString()=='null' ? "" : "top HR: "+data["maximum"].toString()),
                    //todo hazard
                    Text(jsonDecode(utf8.decode(base64.decode(data["zones"]))).toString().substring(0,35)),
                    Text(jsonDecode(utf8.decode(base64.decode(data["samples"]))).toString().substring(0,35)),



                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("back")),



                  ],
                )],
            )

        )

    );
  }

}



