import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_toggle_tab/helper.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _tabIconIndexSelected = 0;

  var _listTextTabToggle = ["uploadtime", "calories", "average", "duration", "maximum"];

  var _listIconTabToggle = [
    Colors.red,
    Colors.green,
  ];
  var _listGenderText = ["Ascendant", "Descendant"];
  var _listGenderEmpty = ["", ""];

  @override
  Widget build(BuildContext context) {
    var _tabTextIndexSelected = Provider.of<AppState>(context).sort;
    var _tabTextIconIndexSelected = Provider.of<AppState>(context).asc ? 1 : 0;

    print(_tabTextIndexSelected);
    return Expanded(child:Scaffold(
      appBar: AppBar(
        title: Text("Flutter Tab Toggle"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// Basic Toggle Sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Select which order",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            FlutterToggleTab(
              // width in percent
              width: 90,
              borderRadius: 30,
              height: 50,
              selectedIndex: _tabTextIndexSelected,
              selectedBackgroundColors: [Colors.blue, Colors.blueAccent],
              selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              unSelectedTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              labels: _listTextTabToggle,
              selectedLabelIndex: (index) {
                setState(() {
                  _tabTextIndexSelected = index;
                  print(_listTextTabToggle[index]);
                  Controller().fetchActivitiesBy(context, _listTextTabToggle[index]);
                });
              },
              isScroll: false,
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Divider(
              thickness: 2,
            ),

            /// Text with icon sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select view order: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  FlutterToggleTab(
                    width: 50,
                    borderRadius: 15,
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    labels: _listGenderText,
                    selectedIndex: _tabTextIconIndexSelected,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabTextIconIndexSelected = index;
                        Controller().toggleAsc(context);
                      });
                    },
                  ),
                ],
              ),
            ),

            /// Icon with Text Button Sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Selected order : ${_listGenderText[_tabTextIconIndexSelected]} ",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Divider(
              thickness: 2,
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),

            /// Icon button sample
            Text(
              "Select your color",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select your sex : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  FlutterToggleTab(
                    width: 40,
                    borderRadius: 15,
                    selectedIndex: _tabIconIndexSelected,
                    selectedTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: TextStyle(
                        color: Colors.cyan,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    labels: _listGenderEmpty,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabIconIndexSelected = index;
                      });
                    },
                    marginSelected:
                    EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Text(
              "Selected sex index: $_tabIconIndexSelected ",
              style: TextStyle(fontSize: 20),
            ),
            Divider(
              thickness: 2,
            ),




          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}