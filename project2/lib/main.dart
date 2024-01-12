import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Swapnil'),
          backgroundColor: Colors.black,
        ),
        body:SizedBox(
          height: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 200,
                width: 100,
                color: Colors.black,
              ),
              Container(
                height: 200,
                width: 100,
                color: Colors.pink,
              )
            ],
          ),
        ),
      ),
    );
  }
}
