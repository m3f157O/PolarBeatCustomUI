



import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/view/exercise_view.dart';
import 'package:custom_polar_beat_ui_v2/view/starting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TODO NULL CHECK PROPERLY

class ShowData extends StatefulWidget {

  const ShowData({Key? key}) : super(key: key);


  @override
  RequestAndShow createState() => RequestAndShow();
}


class RequestAndShow extends State<ShowData> {

  late Future<List<Map<String,Object>>> msg;
  late Future<List<Map<dynamic,dynamic>>> msg2;


  Future<List<Map<String,Object>>> fetchActivities() async {

    return Controller().fetchActivities();
  }


  @override
  void initState() {
    super.initState();

    msg=fetchActivities();
    msg2=fetchSavedActivities();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          FutureBuilder<List<Map<String,Object>>>(
          future: msg,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              {
                if (snapshot.data!.isEmpty&&!snapshot.data!.isNotEmpty) {
                  return const Text('NO NEW DATA TO DISPLAY');
                }
              return ListView.builder(
                itemBuilder: (context, index){
                  return ListTile(
                      title: Text(snapshot.data!.elementAt(index)["sport"]!.toString()),
                      subtitle: const Text("new"),
                      leading: const Icon(Icons.hourglass_empty),
                      dense: true,
                      tileColor: Colors.grey,
                      onTap: () {
                        setState(() {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  ExerciseView(snapshot.data!.elementAt(index))));

                        },
                        );
                      }
                  );


                },
                itemCount: snapshot.data!.length,
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
          FutureBuilder<List<Map<dynamic,dynamic>>>(
            future: msg2,
            builder: (context, snapshot) {
              if (snapshot.hasData)
              {
                if (snapshot.data!.isEmpty&&!snapshot.data!.isNotEmpty) {
                  return const Text('NO DATA TO DISPLAY');
                }
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return ListTile(
                        title: Text(snapshot.data!.elementAt(index)["sport"]!.toString()),
                        subtitle: const Text("old"),
                        leading: const Icon(Icons.hourglass_empty),
                        dense: true,
                        tileColor: Colors.grey,
                        onTap: () {
                          setState(() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ExerciseView(snapshot.data!.elementAt(index))));

                          },
                          );
                        }
                    );


                  },
                  itemCount: 3,
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
    );

  }

  Future<List<Map<dynamic, dynamic>>> fetchSavedActivities() {
    return Controller().fetchSavedActivities();
  }

}




