                /*showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Payment Successful'),
                    content: const Text('Thank you for your payment!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // You might want to navigate back to the home screen
                          //Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );*/

import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget{
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();  
}

class _QuizState extends State<Quiz>{
    int count = 1;
    int ans = 1;
    int temp = 0;
    int x = 0;
    List<String> al = ["","","",""];
    bool flag1 = false;
    bool flag2 = false;
    bool flag3 = false;
    bool flag4 = false;

  void setColor(int x){
    if(temp==0){
      if(x==1){
        flag1 = true;
        flag2 = true;
      }else if(x==2){
        flag2 = true;
      }else if(x==3){
        flag2 = true;
        flag3 = true;
      }else if(x==4){
        flag2 = true;
        flag4 = true;
      }
    }
    temp++;
  }
  
  @override
  Widget build (BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz App',
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              "Question$count",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),

            const SizedBox(height: 50),

            Text(
              'Question$count: What is Flutter?',
              style:const TextStyle(
                fontSize: 20,
              ),
            ),

            const SizedBox(height: 40),
            
            Container(
              height: 30,
              width: 200,
              color: flag1?Colors.red:Colors.black,
              child: TextButton(onPressed: (){
                setState(() {
                  setColor(1);
                });
              }, child:const Text('Language',style: TextStyle(color: Colors.white),)),
            ),

            const SizedBox(height: 20),

            Container(
              height: 30,
              width: 200,
              color: flag2?Colors.green:Colors.black,
              child: TextButton(onPressed: (){
                setState(() {
                  setColor(2);
                });
              }, child:const Text('Framework',style: TextStyle(color: Colors.white),)),
            ),

            const SizedBox(height: 20),

            Container(
              height: 30,
              width: 200,
              color: flag3?Colors.red:Colors.black,

              child: TextButton(onPressed: (){
                setState(() {
                  setColor(3);
                });
              }, child:const Text('Mobile',style: TextStyle(color: Colors.white),)),
            ),

            const SizedBox(height: 20),

            Container(
              height: 30,
              width: 200,
              color:flag4?Colors.red:Colors.black,
              child: TextButton(onPressed: (){
                setState(() {
                  setColor(4);
                });
              }, child:const Text('None Of the Above',style: TextStyle(color: Colors.white),)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            count++;
          });
          if(count>10){
            showDialog(
              context: context, 
              builder: (context) => AlertDialog(
                title: const Text('Last Question'),
                content: const Text('Quiz Ended Thanks for Your Time'),
                actions: [
                  TextButton(onPressed:(){
                    setState(() {
                      count = 1;
                    });
                  }, child: const Text('Ok'))
                ],
              )
            );
          }
        },
        backgroundColor: Colors.black,
        child: const Text(
          'Next'
        ),
      ),
    );
  }
}