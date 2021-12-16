import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
      return DebugAuthCode();
  }




}



class DebugAuthCode extends State<StartingScreen> {

  late Future<String> msg;
  @override
  void initState() {
    super.initState();

    msg=Controller().fetchTokenOnStart();


  }



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

                  FutureBuilder<String>(
                    future: msg,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        if (snapshot.data!.isNotEmpty) {
                          return ElevatedButton(
                            onPressed: () => Controller().toGetTokenFromPolar(context),
                            child: const Text("LOGIN WITH \nEXISTING TOKEN"),
                          );
                        }
                        else {
                          return ElevatedButton(
                            onPressed: () => Controller().toLoginToPolar(context),
                            child: const Text("REQUEST TOKEN"),
                          );                        }

                        }
                      else {
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                                            }


                      return const CircularProgressIndicator();


                    },
                  ),


                  ElevatedButton(
                    onPressed: () => Controller().reset(context),
                    child: const Text("DROP DB (restart app after this)"),
                  ),

                ],
              )],
            )

                  )

            );
  }
}

