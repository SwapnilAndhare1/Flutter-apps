import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget{
  const ListViewDemo({super.key});

  @override
  State createState() => _ListViewState();
}

class _ListViewState extends State{

  List<String> imageList = [
    "https://tse1.mm.bing.net/th?id=OIP._ZZT_ab4BwBvwcrxY3G_xQHaEK&pid=Api&P=0&h=220",
    "https://tse1.mm.bing.net/th?id=OIP.gZ5N9J_snbudcEeG50oV2AHaEK&pid=Api&P=0&h=220",
    "https://tse2.mm.bing.net/th?id=OIP._Taszk1iKBKL74YqY-4H2gHaD4&pid=Api&P=0&h=220",
    "https://tse3.mm.bing.net/th?id=OIP.g8Q_z_VrM-wg7mXLocimHgHaFj&pid=Api&P=0&h=220",
    "https://tse3.mm.bing.net/th?id=OIP.onPNEadPT-ib_GJetnRzwQHaE8&pid=Api&P=0&h=220"
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Demo'),
        centerTitle:true,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Image.network(
              imageList[index]
            ),
          );
        },
      ),
    );
  }
}