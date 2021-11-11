

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GetTokenFromPolar extends StatefulWidget {

  const GetTokenFromPolar({Key? key}) : super(key: key);


  @override
  TokenRequestToPolar createState() => TokenRequestToPolar();
}


class TokenRequestToPolar extends State<GetTokenFromPolar> {

  late Future<bool> msg;

  Future<bool> fetchAccessToken() async {

    return await Controller().fetchToken();

  }


  Future<void> registerUser() async {

    Controller().registerUser();
  }


  @override
  void initState() {
    super.initState();

    msg=fetchAccessToken();

  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GET YOUR TOKEN',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('THIS IS YOUR TOKEN'),
        ),
        body: Center(
          child: FutureBuilder<bool>(
            future: msg,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //todo remove temp screen
                registerUser();



                return ElevatedButton(
                    onPressed: () => Controller().toViewMenu(context),
                    child: const Text("TOKEN REQUEST SUCCESSFULL, PROCEED"));

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }


              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}




