import 'package:flutter/material.dart';

class Assignment2 extends StatefulWidget{
  const Assignment2({super.key});

  @override
  State<Assignment2> createState() => _Assignment2State();
}

class _Assignment2State extends State<Assignment2>{
  bool box1Color=false;
  bool box2Color=false;

  @override
  Widget build(BuildContext context){
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Color Box'),
          backgroundColor: Colors.black,
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Column(
                  children: [
                    Container(
                      
                      height: 100,
                      width: 100,
                      color: box1Color?Colors.orange:Colors.pink
                    ),


                    const SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(onPressed: (){
                      setState(() {
                        box1Color=!box1Color;
                        });
                      },
                      child: const Text('Color Box 1'),
                      style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.black)),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: box2Color?Colors.red:Colors.black,
                    ),


                    const SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(onPressed: (){
                      setState(() {
                        box2Color=!box2Color;
                        });
                      },
                      child: const Text('Color Box 2'),
                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      
    );
  }
}