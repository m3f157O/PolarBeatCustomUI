

import 'package:custom_polar_beat_ui_v2/model/model.dart';
import 'package:custom_polar_beat_ui_v2/view/sort.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortScreen extends StatefulWidget {
  const SortScreen({Key? key}) : super(key: key);


  @override
  SelectSort createState() => SelectSort();
}


class SelectSort extends State<SortScreen> {


  @override
  Widget build(BuildContext context) {
    Color second = Provider.of<AppState>(context).second;



    return Center( child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Align(alignment: Alignment.topCenter,
                    child:   Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: second,
                          gradient: LinearGradient(
                              stops: [0,1],
                              colors: [
                                second,
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 22,
                            right: 22,
                            top: 20,
                            bottom: 10
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [






                            ],
                          ),
                        ),
                      ),
                    )
                ),
                const Sort(),

              ],

            ),);
  }

}



