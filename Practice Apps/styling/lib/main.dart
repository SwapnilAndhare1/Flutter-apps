import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Styling'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            //color: Colors.blueGrey,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: const BorderRadius.all(Radius.circular(150)),
              border: Border.all(color:Colors.orangeAccent,width: 1),
              gradient: const LinearGradient(
                stops: [0.4,0.8],
                colors: [Colors.orange,Colors.yellow]
              )
            ),
            //child:Image.network('https://static.vecteezy.com/system/resources/previews/012/836/401/non_2x/cartoon-character-hand-holding-victory-prize-cup-trophy-3d-illustration-free-photo.jpg')
          )
        ),
      ),
    );
  }
}
