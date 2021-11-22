

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ShowProfile extends StatelessWidget {

  final Map data;
  const ShowProfile(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auth0 2',
        home: Scaffold(

            body: Column(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [


                Text(data["firstname"],
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                Text(data["lastname"],
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                Text(data["birthdate"],
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),


          ],

            )

        )

    );
  }

}




