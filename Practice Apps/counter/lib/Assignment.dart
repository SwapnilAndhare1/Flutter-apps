import 'package:flutter/material.dart';

class Assignment extends StatefulWidget{
  const Assignment({super.key});
  @override
  State<Assignment> createState() => _Assignment(); 
}

class _Assignment extends State<Assignment>{
  int? _count = 0;

  void _increment(){
    setState(() {
      _count = _count! + 1;
    });
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Counter',
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$_count',
            ),
            Container(
              height: 20,
            ),
            ElevatedButton(onPressed:_increment, child:const Text('Button'),)
          ],
        ),
      ),
    );
  }
}
