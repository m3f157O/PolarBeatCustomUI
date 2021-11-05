
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
                    Text("Calories "+data["calories"].toString()),
                    Text("Device "+data["device"]),
                    Text("Distance "+data["distance"].toString()),
                    Text("Start Time "+data["starttime"]),


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



