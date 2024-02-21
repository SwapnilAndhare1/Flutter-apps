import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int count = 0;
  List<int> list = [];

  void increment() {
    setState(() {
      count++;
      list.add(count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Demo"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            height: 30,
            color: Colors.amber,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            child: Text("${list[index]}"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: increment,
        backgroundColor: Colors.black,
        child: const Text('Next'),
      ),
    );
  }
}
