import 'package:custom_polar_beat_ui_v2/controller/controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class debugAuthCode extends StatelessWidget {

  const debugAuthCode({Key? key}) : super(key: key);

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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () => BaseCommand().toGetTokenFromPolar(context),
                              child: const Text("THIS IS A DEBUG SCREEN"),
                            ),
                          ],
                        )                   ]
                  )
                ]
            )
        )
    );
  }
}

