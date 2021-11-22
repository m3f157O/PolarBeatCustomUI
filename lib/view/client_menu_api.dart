

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

    return const ShowData();


  }
}

