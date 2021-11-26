

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowProfile extends StatelessWidget {

  final Map data;
  const ShowProfile(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,//>3 ? 3 : data.length,
                  itemBuilder: (context, index) {
                    return Builder(builder: (context) {
                      String temp=data.entries.elementAt(index).value.toString();
                      return ListTile(
                          title: Text(temp),
                          tileColor: Colors.amber,
                          dense: true,

                          onTap: () {

                          }
                    );
                  });
            },
            ),


              ],

            );
  }

}




