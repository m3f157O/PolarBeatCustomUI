
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StandardView();
  }




}



class StandardView extends State<ExerciseView> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auth0 2',
        home: Scaffold(

            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [

                    Text("YOU WILL SEE DATA HERE"),




                  ],
                )],
            )

        )

    );
  }
}

