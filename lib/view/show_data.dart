



import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/exercise_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//TODO NULL CHECK PROPERLY

class ShowData extends StatefulWidget {

  const ShowData({Key? key}) : super(key: key);


  @override
  RequestAndShow createState() => RequestAndShow();
}


class RequestAndShow extends State<ShowData> {

  late List<Map<dynamic,dynamic>> msg;
  late List<Map<dynamic,dynamic>> msg2;


  Future<bool> fetchActivities() async {

    return Controller().fetchActivities(context);
  }

  Future<bool> fetchSavedActivities() {
    return Controller().fetchSavedActivities(context);
  }

  @override
  void initState() {
    super.initState();

    fetchSavedActivities();
    fetchActivities();
  }


  @override
  Widget build(BuildContext context) {
    msg2 = Provider.of<AppState>(context).savedActivities;
    msg = Provider.of<AppState>(context).newActivities;

    return Column(
        children: [
          //todo add cool spinner

          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
            itemCount: msg.length>3 ? 3 : msg.length,
            itemBuilder: (context, index) {
              return Builder(builder: (context) {
                String temp=msg.elementAt(index).entries.first.value.toString();
                return ListTile(
                    title: Text(temp),
                    subtitle: const Text("new"),
                    tileColor: Colors.yellow,
                    dense: true,

                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ExerciseView(msg.elementAt(index))));

                      },
                      );
                    }
                );
              });
            },
          ),

          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
            itemCount: msg2.length>3 ? 3 : msg2.length,
            itemBuilder: (context, index) {
              return Builder(builder: (context) {
                String temp=msg2.elementAt(index).entries.first.value.toString();
                return ListTile(
                  title: Text(temp),
                    subtitle: const Text("old"),
                    tileColor: Colors.grey,
                    dense: true,

                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ExerciseView(msg2.elementAt(index))));

                      },
                      );
                    }
                );
              });
            },
          ),


    ],
    );

  }



}




