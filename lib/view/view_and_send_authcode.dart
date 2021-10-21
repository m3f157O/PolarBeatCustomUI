import 'package:custom_polar_beat_ui_v2/controller/controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DebugAuthCode extends StatelessWidget {

  const DebugAuthCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auth0 2',
        home: Scaffold(

            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                            ElevatedButton(
                              onPressed: () => Controller().toGetTokenFromPolar(context),
                              child: const Text("THIS IS A DEBUG SCREEN"),
                            ),
                          ],
                        )
                  )

            );
  }
}

