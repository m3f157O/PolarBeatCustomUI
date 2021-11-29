import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool? isHeartIconTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 66,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Hero(
                    tag: "sleepMeditation",
                    child: Material(
                      color: Colors.transparent,
                      child: Text("POLAR USER PROFILE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28),
                ),
                SizedBox(height: 25),
                SizedBox(
                  height: 279,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(width: 28),
                      Container(
                        height: 280,
                        width: 280,
                      ),
                      SizedBox(width: 20),
                      Container(
                        height: 280,
                        width: 280,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),

                      ),
                    ],
                  ),
                ),
                SizedBox(height: 46),
                Padding(
                  padding: EdgeInsets.only(left: 28, right: 28, bottom: 80),
                  child: Text(
                    "Meditation is a practice where an individual uses a technique – such as mindfulness, or focusing their mind on a particular object, thought or activity – to train attention and awareness, and achieve a mentally clear and emotionally calm and stable state. Scholars have found meditation difficult to define, as practices vary both between traditions and within them.",
                    style: TextStyle(
                        color: Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                )
              ],
            ),

            Align(alignment: Alignment.topCenter,
                child:   Container(
                  color:  Color(0xff121421),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 22,
                        right: 22,
                        top: 20,
                        bottom: 10
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),

                            ),
                          ),


                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: onHeartIconTapped,
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),
                            ),
                          ),




                        ],
                      ),
                    ),
                  ),
                )
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 87,
                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        stops: [0,1],
                        colors: [
                          Color(0xff121421),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    )
                ),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: onStartButtonPressed,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(0xff4A80F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          height: 56,
                          width: 319,
                          child: Center(child: Text("Start", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.red),)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  void onStartButtonPressed() {

  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }
}