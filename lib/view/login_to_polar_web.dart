
import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class LoginToPolarWeb extends StatefulWidget {
  const LoginToPolarWeb({Key? key}) : super(key: key);

  @override
  _LoginToPolarWebState createState() => _LoginToPolarWebState();
}

class _LoginToPolarWebState extends State<LoginToPolarWeb>
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authenticating..."),
      ),
      body: InAppWebView(
          initialUrlRequest:
          URLRequest(url: Uri.parse("https://flow.polar.com/oauth2/authorization?response_type=code&client_id=$POLAR_CLIENT_ID")),
          onLoadStart: (controller, url) {
            var callback='com.auth0.custompolarinterface://login-callback?code=';
            if(url!.toString().contains(callback,0)) {
              String code=url.toString().substring(callback.length);
              BaseCommand().setCode(context,code);
              BaseCommand().toViewCode(context);
            }
          }
      ),
    );

  }
}



