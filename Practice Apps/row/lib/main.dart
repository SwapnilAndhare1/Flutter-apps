import 'package:flutter/material.dart';

void main()=>runApp(const myApp());

class myApp extends StatelessWidget{
  const myApp({super.key});

  @override
  Widget build (BuildContext Context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Row'
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.green,
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.blue,
              ),
            ]
          ),
        ),
      ),
    );
  }
}