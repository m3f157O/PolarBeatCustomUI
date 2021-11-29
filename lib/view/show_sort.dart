

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:custom_polar_beat_ui_v2/view/sort.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class CrazySort extends StatefulWidget {
  const CrazySort({Key? key}) : super(key: key);


  @override
  SelectSort createState() => SelectSort();
}


class SelectSort extends State<CrazySort> {


  @override
  Widget build(BuildContext context) {
    bool ciccia = Provider.of<AppState>(context).asc;
    var _selectedIndex= 0; // you can change selected with update this
    var _tabTextIndexSelected = 1;
    var _tabTextIconIndexSelected = 0;
    var _tabIconIndexSelected = 0;
    var _tabSelectedIndexSelected = 0;

    var _listTextTabToggle = ["Tab A (10)", "Tab B (6)", "Tab C (9)"];
    var _listTextSelectedToggle = [
      "Select A (10)",
      "Select B (6)",
      "Select C (9)"
    ];
    var _listIconTabToggle = [
      Icons.person,
      Icons.pregnant_woman,
    ];
    var _listGenderText = ["Male", "Female"];
    var _listGenderEmpty = ["", ""];

    return Center( child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
// Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor


                MyHomePage(),

              ],

            ),);
  }

}



