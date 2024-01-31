import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{

  const MyApp({super.key});

  @override
  Widget build (BuildContext context){
    return const MaterialApp(
      title: 'Toggle Box',
      debugShowCheckedModeBanner:false,
      home:ToggleBox(),
    );
  }
}

class ToggleBox extends StatefulWidget{

  const ToggleBox({super.key});

  @override
  State<ToggleBox> createState() => _ToggleBoxState();
}

class _ToggleBoxState extends State<ToggleBox>{
  int count1 = 1;
  int count2 = 1;
  
  Color setBox1Color(){
    if(count1%3==1){
      return Colors.red;
    }else if(count1%3==2){
      return Colors.green;
    }else{
      return Colors.blue;
    }
  }

  Color setBox2Color(){
    if(count2%3==1){
      return Colors.black;
    }else if(count2%3==2){
      return Colors.amber;
    }else{
      return Colors.pink;
    }
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Toggle Box',
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: setBox1Color(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        count1 = count1 + 1;
                      });
                    },
                    style: const ButtonStyle(
                      backgroundColor:MaterialStatePropertyAll(
                        Colors.black
                      ),
                    ),
                    child: const Text(
                      'Button 1'
                    ))
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: setBox2Color(),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(onPressed: (){
                      setState(() {
                        count2 = count2 + 1;
                      });
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.black,
                      )
                    ),
                    child: const Text(
                      'Button 2'
                    ))
                  ],
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed:(){
                  setState(() {
                    count1++;
                    count2++;
                  });
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)
                ), 
                child: const Text('Button3'))
              ],
            )
          ]
        ),
      ),      
    );
  }
}