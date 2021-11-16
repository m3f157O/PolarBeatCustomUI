

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class ClientMenu extends StatefulWidget {


  const ClientMenu({Key? key}) : super(key: key);


  @override
  ClientMenuAPI createState() => ClientMenuAPI();
}

class ClientMenuAPI extends State<ClientMenu> {


  late Map<dynamic,dynamic> msg;




  Future<bool> fireUserInfoRequest() async {

    return Controller().fetchProfile(context);
  }



  @override
  void initState() {
    super.initState();
    fireUserInfoRequest();

  }


  @override
  Widget build(BuildContext context) {
    msg = Provider.of<AppState>(context).profile;

    return MaterialApp(
      title: 'BASIC CLIENT MENU',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('BASIC CLIENT MENU'),
          ),
          body: Center(

              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  const ShowData(),


                  ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    scrollDirection: Axis.vertical,
                    itemCount: msg.length>3 ? 3 : msg.length,
                    itemBuilder: (context, index) {
                      return Builder(builder: (context) {
                        String temp=msg.entries.elementAt(index).value.toString();
                        return ListTile(
                            title: Text(temp),
                            tileColor: Colors.amber,
                            dense: true,

                            onTap: () {

                            }
                        );
                      });
                    },
                  ),



                ],
              )
          )
      ),

    );
  }
}

