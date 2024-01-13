import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color? name = Colors.white;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: name,
        appBar: AppBar(
          title: const Text('BUTTON  APPLICATION',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: SizedBox(
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.black,
                ),
                Container(
                  height: 50,
                  width: 50,
                ),
                Container(
                  width: 50,
                  height: 50,
                  child:ElevatedButton(
                  onPressed: (){
                    print("Hi Whats Going on");
                  
                  },
                  child: const Text('+',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  ),
                ),
                ],
                )
              ],
          ),
        ),
      ),
    );
  }
}
