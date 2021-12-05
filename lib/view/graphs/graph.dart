
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class ChartData {
  final num value;
  final num year;

  ChartData(this.value, this.year);
}

class ShowHeartbeat extends StatefulWidget {
  var color;

  var data;

  var title;


  ShowHeartbeat({
    Key? key,
    required this.data,
    required this.color,
    required this.title,
  }) : super(key: key);




  @override
  RequestAndShow createState() => RequestAndShow(data: data,color: color,title: title);
}


class RequestAndShow extends State<ShowHeartbeat> {


  RequestAndShow({
    Key? key,
    required this.data,
    required this.color, required this.title,
  });


  final Map data;
  final Color color;
  final String title;

  List<ChartData> heartBeat=[];
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  late TrackballBehavior _trackballBehavior;

  void onItemTapped() {
    return;
  }

  void processHeartbeat(Map toProcess) {
    List can=jsonDecode(utf8.decode(base64.decode(toProcess["samples"])));
    for(int k=0;k<1;k++) {
      List<String> temp=can[k]['data'].toString().split(',');
      for(int i=0;i<temp.length;i++) {
        heartBeat.add(ChartData(int.parse(temp.elementAt(i)),i));
      }
    }


    if(can.length>1) {
      List<String> temp=can[1]['data'].toString().split(',');
      for(int i=0;i<temp.length;i++) {
        print(temp.elementAt(i));
        // TODO CORRECT DATA TYPE
      }
    }

  }
  final int _selectedIndex=1;

  void initState(){
    _trackballBehavior = TrackballBehavior(
        enable: true,
        // Display mode of trackball tooltip
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints
    );

    processHeartbeat(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    CrosshairBehavior crosshairBehavior = CrosshairBehavior(
      // Enables the crosshair
        enable: true,
        lineColor: Colors.red,
        lineDashArray: <double>[5,5],
        lineWidth: 2,
        lineType: CrosshairLineType.vertical
    );

    return Column(
      children: [
        Expanded( //
          flex: 1,// add this
          child: Center(
              heightFactor: 200,
              child:SfCartesianChart(

                trackballBehavior: _trackballBehavior,
                primaryXAxis: NumericAxis(
                  interactiveTooltip: const InteractiveTooltip(
                    // Enables the crosshair tooltip
                    enable: true,
                    color: Colors.grey  ,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  interactiveTooltip: const InteractiveTooltip(
                    // Enables the crosshair tooltip
                      enable: true

                  ),
                ),



                title: ChartTitle(text: title),
                series: <ChartSeries<ChartData, num>>[
                  LineSeries<ChartData, num>(
                    dataSource: heartBeat,


                    xValueMapper: (ChartData sales, _) => sales.year,
                    yValueMapper: (ChartData sales, _) => sales.value,

                  ),
                ],
              )),
        ),

      ],
    );

  }



}


class ShowHeartzones extends StatefulWidget {
  var color;

  var data;

  var title;


  ShowHeartzones({
    Key? key,
    required this.data,
    required this.color, required this.title,
  }) : super(key: key);

  @override
  RequestAndShow createState() => RequestAndShow(data: data,color: color,title: title);
}


class RequestAndShowZones extends State<ShowHeartzones> {


  RequestAndShowZones({
    Key? key,
    required this.data,
    required this.color, required this.title,
  });


  final List<ChartData> data;
  final Color color;
  final String title;

  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  late TrackballBehavior _trackballBehavior;

  void onItemTapped() {
    return;
  }

  final int _selectedIndex=1;

  void initState(){
    _trackballBehavior = TrackballBehavior(
        enable: true,
        // Display mode of trackball tooltip
        tooltipDisplayMode: TrackballDisplayMode.floatAllPoints
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    CrosshairBehavior crosshairBehavior = CrosshairBehavior(
      // Enables the crosshair
        enable: true,
        lineColor: Colors.red,
        lineDashArray: <double>[5,5],
        lineWidth: 2,
        lineType: CrosshairLineType.vertical
    );

    return Column(
      children: [
        Expanded( //
          flex: 1,// add this
          child: Center(
              heightFactor: 200,
              child:SfCartesianChart(

                trackballBehavior: _trackballBehavior,
                primaryXAxis: NumericAxis(
                  interactiveTooltip: const InteractiveTooltip(
                    // Enables the crosshair tooltip
                    enable: true,
                    color: Colors.grey  ,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  interactiveTooltip: const InteractiveTooltip(
                    // Enables the crosshair tooltip
                      enable: true

                  ),
                ),


                title: ChartTitle(text: title),
                series: <ChartSeries<ChartData, num>>[
                  LineSeries<ChartData, num>(
                    dataSource: data,

                    xValueMapper: (ChartData sales, _) => sales.year,
                    yValueMapper: (ChartData sales, _) => sales.value,

                  ),
                ],
              )),
        ),

      ],
    );

  }



}









