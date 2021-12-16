/// Package imports
import 'dart:convert';

import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import 'fast_iso.dart';

/// Local imports
class ChartData {
  final num value;
  final num year;

  ChartData(this.value, this.year);
}
///Renders histogram chart samples
///
///
class HistogramDefault extends StatefulWidget {


  const HistogramDefault({Key? key, required this.data}) : super(key: key);
  final Map data;

  @override
  _HistogramDefaultState createState() => _HistogramDefaultState(data: data, color: Colors.black54,title :"dog");
}

class _HistogramDefaultState extends State<HistogramDefault> {
  late bool _showDistributionCurve;
  late TooltipBehavior _tooltipBehavior;
  late final Map data;
  List<ChartData> chartData=[];
  _HistogramDefaultState({
    required this.data,
    required this.color, required this.title,
  });


  final Color color;
  final String title;
  Widget buildSettings(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter stateSetter) {
          return Row(
            children: <Widget>[
              const Text('Show distribution line ',
                  style: TextStyle(
                    fontSize: 16,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: 90,
                    child: CheckboxListTile(
                        value: _showDistributionCurve,
                        onChanged: (bool? value) {
                          setState(() {
                            _showDistributionCurve = value!;
                            stateSetter(() {});
                          });
                        })),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List can=jsonDecode(utf8.decode(base64.decode(data["zones"])));

    if(can.isNotEmpty)
    {
      for(int i=0;i<can.length;i++) {
        chartData.add(ChartData(toDuration(can.elementAt(i)['in-zone']).inSeconds,can.elementAt(i)['index']));

      }
      return _buildDefaultHistogramChart();

    }
    else {
      return const SizedBox();
    }
  }

  /// Get the cartesian chart with histogram series
  SfCartesianChart _buildDefaultHistogramChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: "Heart Rate Zones"),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        minimum: 0,
        maximum: 5,
      ),
      primaryYAxis: NumericAxis(
          name: 'Number of Students',
          minimum: 0,
          maximum: 220,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getHistogramSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  ///Get the histogram series
  List<HistogramSeries<ChartData, double>> _getHistogramSeries() {

    return <HistogramSeries<ChartData, double>>[
      HistogramSeries<ChartData, double>(
        name: 'Score',
        dataSource: chartData,

        /// If we enable this property distribution line is sets in histogram.
        showNormalDistributionCurve: _showDistributionCurve,

        /// It used to add the color for distribution line.
        curveColor: const Color.fromRGBO(192, 108, 132, 1),
        binInterval: 1,

        /// It used to add the dashes line for distribution line.
        curveDashArray: <double>[12, 3, 3, 3],
        width: 0.99,
        curveWidth: 2.5,
        yValueMapper: (ChartData sales, _) => sales.value,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
      )
    ];
  }

  @override
  void initState() {
    _showDistributionCurve = true;
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }
}