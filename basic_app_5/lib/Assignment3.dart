import 'package:flutter/material.dart';

class Assignment3 extends StatefulWidget{
  const Assignment3({super.key});

  @override
  State<Assignment3> createState() => _Assignment3State();
}

class _Assignment3State extends State<Assignment3>{
  int? selectedIndex = 0;
  final List<String> imageList = ["https://tse4.mm.bing.net/th?id=OIP.lOhlBcdGa8jSHIEAMf6DWAHaGB&pid=Api&P=0&h=220",
    "http://upload.wikimedia.org/wikipedia/commons/f/f7/Charminar_india.jpg",
  "http://dynamic.tourtravelworld.com/hotspot-images/charminar-hyderabad-1912.jpg",

  ];
  void showNextImage(){
    setState(() {
      selectedIndex=selectedIndex!+1;
    });
  }
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Display Images'),
        ),

        body: Center(
          child: Column(children: [
            const SizedBox(
              height: 100,
            ),
            Image.network(
              imageList[selectedIndex!],
              width: 300,
              height: 300,
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(onPressed: showNextImage, child: const Text('Next')),

            const SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                setState(() {
                  selectedIndex=0;
                });
              },
             child: const Text('Reset'))
          ],)
        )
      );
    }
}