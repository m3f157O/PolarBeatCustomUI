

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:custom_polar_beat_ui_v2/view/show_profile.dart';
import 'package:custom_polar_beat_ui_v2/view/show_sort.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ClientMenu extends StatefulWidget {


  const ClientMenu({Key? key}) : super(key: key);


  @override
  ClientMenuAPI createState() => ClientMenuAPI();
}

class ClientMenuAPI extends State<ClientMenu> {


  late int selected;
  Future<bool> fetchActivities() async {

    return Controller().fetchActivities(context);
  }

  Future<bool> fetchSavedActivities() {
    return Controller().fetchActivitiesByDate(context);
  }




  Future<bool> fireUserInfoRequest() async {

    return Controller().fetchProfile(context);
  }

  Future<bool> statsRoutine() async {

    return Controller().statsRoutine(context);
  }



  @override
  void initState() {
    super.initState();
    fireUserInfoRequest();
    fetchSavedActivities();
    fetchActivities();
    statsRoutine();


  }

  late int _selectedIndex=0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   Widget getWidget() {
    if(_selectedIndex==1) {
      return const ShowData();
    } else if(_selectedIndex==2){
      return const ShowProfile();
    } else {
      return const SortScreen();

    }

   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.stairs),
            label: 'Sort',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flutter_dash_rounded),
            label: 'Exercises',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap:_onItemTapped,
      ),
    );


  }
}


