import 'package:flutter/material.dart';

class Assignment1 extends StatefulWidget{
  const Assignment1({super.key});

  @override
  State<Assignment1> createState()=> _Assignment1State();
}

class _Assignment1State extends State<Assignment1>{
  int? _count = 0;

  void _printTableValue(){
    setState(() {
      _count = _count! + 2;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table of 2'),
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cilck Button To Print Table Values',
              style: TextStyle(
                fontSize: 25,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              "$_count",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: _printTableValue, 
              child: const Text("Print"),
              style: const ButtonStyle(
                backgroundColor:MaterialStatePropertyAll(
                  Colors.black
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}