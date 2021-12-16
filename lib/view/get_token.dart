

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class GetToken extends StatefulWidget {

  const GetToken({Key? key}) : super(key: key);


  @override
  TokenRequest createState() => TokenRequest();
}


class TokenRequest extends State<GetToken> {

  late Future<bool> token;

  Future<bool> fetchAccessToken() async {

    return await Controller().fetchToken();

  }


  Future<void> registerUser() async {

    Controller().registerUser();
  }


  @override
  void initState() {
    super.initState();

    token=fetchAccessToken();

  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GET YOUR TOKEN',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Scaffold(

        body: Center(
          child: FutureBuilder<bool>(
            future: token,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //todo remove temp screen
                registerUser();
                return ElevatedButton(
                    onPressed: () => Controller().toViewMenu(context),
                    child: const Text("TOKEN VALID, LOGIN TO POLAR"));

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




