

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ClientMenu extends StatefulWidget {


  const ClientMenu({Key? key}) : super(key: key);


  @override
  ClientMenuAPI createState() => ClientMenuAPI();
}

class ClientMenuAPI extends State<ClientMenu> {


  late Future<Map<String,Object>> _msg;




  Future<Map<String,Object>> fireUserInfoRequest() async {

    return Controller().fetchProfile(context);
  }



  @override
  void initState() {
    super.initState();
    _msg=fireUserInfoRequest();

  }


  @override
  Widget build(BuildContext context) {
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


                  FutureBuilder<Map<String,Object>>(
                      future: _msg,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {


                          return ListView.builder(
                            physics: const ScrollPhysics(),

                            itemBuilder: (context, index){
                              return Container(
                                  height: MediaQuery.of(context).size.width * 0.14,
                                  child: ListTile(
                                    leading: const Icon(Icons.radio_button_checked, size: 17),
                                    title: Text(snapshot.data!.values.elementAt(index).toString(), style: const TextStyle(height: 1.3),),
                                  )

                              );

                            },
                            itemCount: 3,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(5),
                            scrollDirection: Axis.vertical,
                          );


                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }


                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                ],
              )
          )
      ),

    );
  }
}

