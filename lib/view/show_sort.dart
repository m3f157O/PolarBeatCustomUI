

import 'package:custom_polar_beat_ui_v2/controller/controller.dart';
import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/show_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SelectSort extends StatelessWidget {

  const SelectSort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool ciccia = Provider.of<AppState>(context).asc;
    return Center( child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Controller().fetchActivitiesByDate(context),
                  child: const Text("Date"),
                ),
                ElevatedButton(
                  onPressed: () => Controller().fetchActivitiesByCalories(context),
                  child: const Text("Calories"),
                ),
                ElevatedButton(
                  onPressed: () => Controller().fetchActivitiesByAverage(context),
                  child: const Text("Average"),
                ),
                ElevatedButton(
                  onPressed: () => Controller().fetchActivitiesByDuration(context),
                  child: const Text("Duration"),
                ),
                ElevatedButton(
                  onPressed: () => Controller().fetchActivitiesByMaximum(context),
                  child: const Text("Maximum"),
                ),
                ElevatedButton(
                  onPressed: () => Controller().toggleAsc(context),
                  child: ciccia ? Text("SHOW DESC") : Text("SHOW ASC"),
                ),

              ],

            ),);
  }

}




