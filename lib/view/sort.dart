import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:flutter_toggle_tab/helper.dart';
import 'package:provider/provider.dart';

class Sort extends StatefulWidget {
  const Sort({Key? key}) : super(key: key);



  @override
  _SortState createState() => _SortState();
}

class _SortState extends State<Sort> {

  var _tabIconIndexSelected = 0;
  var _tabIconIndexSelected2 = 0;

  final _listTextTabToggle = ["uploadtime", "calories", "average", "duration", "maximum"];

  final _listIconTabToggle = [
    Colors.red,
    Colors.green,
    Colors.lightBlue,
    Colors.black,
    Colors.white,
  ];
  final _listGenderText = ["Ascendant", "Descendant"];
  final _listGenderEmpty = ["Red", "Green" , "Blue", "Black","White"];
  final _listGenderEmpty2 = ["Red", "Green" , "Blue", "Black","White"];

  @override
  Widget build(BuildContext context) {
    var _tabTextIndexSelected = Provider.of<AppState>(context).sort;
    var _tabTextIconIndexSelected = Provider.of<AppState>(context).asc ? 1 : 0;
    Color main= Provider.of<AppState>(context,listen: false).main;
    Color second= Provider.of<AppState>(context,listen: false).second;

    return Expanded(child:Scaffold(
      backgroundColor: main,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            /// Basic Toggle Sample
            SizedBox(
              height: heightInPercent(7, context),
            ),
            Text(
              "Select which order",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic,color: second),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            FlutterToggleTab(
              // width in percent
              width: 90,
              borderRadius: 30,
              height: 50,
              unSelectedBackgroundColors: [main],
              selectedIndex: _tabTextIndexSelected,
              selectedBackgroundColors: [main, second],
              selectedTextStyle: TextStyle(
                  color: main.withBlue(100),
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
              unSelectedTextStyle: TextStyle(
                  color: second,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              labels: _listTextTabToggle,
              selectedLabelIndex: (index) {
                setState(() {
                  _tabTextIndexSelected = index;
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
            const Divider(
              thickness: 2,
            ),

            /// Text with icon sample
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select view order: ",
                    style: TextStyle(fontSize: 20,color: second),
                  ),
                 FlutterToggleTab(
                    width: widthInPercent(12,context),
                    unSelectedBackgroundColors: [main],
                    selectedBackgroundColors: [main, second],
                    selectedTextStyle: TextStyle(
                        color: main.withBlue(100),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                    unSelectedTextStyle: TextStyle(
                        color: second,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
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

            SizedBox(
              height: heightInPercent(3, context),
            ),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),

            /// Icon button sample
            Text(
              "Select your color",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: second),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Main : ",
                    style: TextStyle(fontSize: 20,color: second),
                  ),
                  FlutterToggleTab(
                    width: 70,
                    selectedIndex: _tabIconIndexSelected,
                    selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    labels: _listGenderEmpty,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabIconIndexSelected = index;
                        Provider.of<AppState>(context, listen: false).setColor(_listIconTabToggle.elementAt(index));
                      });
                    },
                    marginSelected:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Second : ",
                    style: TextStyle(fontSize: 20,color: second),
                  ),
                  FlutterToggleTab(
                    width: 60,
                    borderRadius: 15,
                    selectedIndex: _tabIconIndexSelected2,
                    selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    unSelectedTextStyle: const TextStyle(
                        color: Colors.cyan,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                    labels: _listGenderEmpty2,
                    selectedLabelIndex: (index) {
                      setState(() {
                        _tabIconIndexSelected2 = index;
                        Provider.of<AppState>(context, listen: false).setSecond(_listIconTabToggle.elementAt(index));
                      });
                    },
                    marginSelected:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightInPercent(3, context),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        stops: const [0,1],
                        colors: [
                          second,
                          main
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    )
                ),

              ),
            ),




          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}