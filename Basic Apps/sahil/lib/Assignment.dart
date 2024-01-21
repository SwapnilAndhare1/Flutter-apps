import 'package:flutter/material.dart';

class Assignment3 extends StatefulWidget{
  const Assignment3({super.key});

  @override
  State<Assignment3> createState() => _Assignment3State();
}

class _Assignment3State extends State<Assignment3>{
  int? selectedIndex = 0;
  final List<String> imageList = ["https://tse2.explicit.bing.net/th?id=OIP.kdbCXOf52mJqF_rX3cULUAHaEK&pid=Api&P=0&h=220",
    "https://tse4.mm.bing.net/th?id=OIP.5ZK8YhsXA90Q5al--48bewHaE8&pid=Api&P=0&h=220",
  "https://tse1.mm.bing.net/th?id=OIP.Y5peo6Gp-oZbO1mIK4arUQHaEK&pid=Api&P=0&h=220",
  "https://tse4.mm.bing.net/th?id=OIF.AMIM4xQQ05tzpCdy2eRfXQ&pid=Api&P=0&h=220"

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