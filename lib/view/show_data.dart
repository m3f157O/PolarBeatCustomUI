



import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/view/starting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShowData extends StatefulWidget {

  const ShowData({Key? key}) : super(key: key);


  @override
  RequestAndShow createState() => RequestAndShow();
}


class RequestAndShow extends State<ShowData> {

  late Future<List<Map<String,Object>>> msg;
  late Future<List<Map<String,Object>>> msg2;


  Future<List<Map<String,Object>>> fetchActivities() async {

    return Controller().fetchActivities();
  }


  @override
  void initState() {
    super.initState();

    msg=fetchActivities();
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
                              MaterialPageRoute(builder: (context) => const StartingScreen()));

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
    ],
    );

  }

}




