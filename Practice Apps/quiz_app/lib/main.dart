
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget{
  const Quiz({super.key});

  @override
  State createState() => _QuizState();
}

class Model{
  final String? Question;
  final List<String> Options;
  final int? Ans;

  const Model({this.Question,required this.Options,this.Ans});
}

class _QuizState extends State<Quiz>{
  bool questionScreen = true;
  int index = 0;
  int selectedIndex = -1;
  int marks = 0;

  List allQuestions = [
    const Model(
      Question:"Which is the Capital India ?",
      Options:["Mumbai","Kolkata","Delhi","Chennai"],
      Ans:2,
    ),
    const Model(
      Question:"Who is the Founder of Apple ?",
      Options:["Steve Jobs","Elon Musk","Bill Gates","Page"],
      Ans:0,
    ),
    const Model(
      Question:"Who is the Founder of Tesla ?",
      Options:["Steve Jobs","Elon Musk","Bill Gates","Page"],
      Ans:1,
    ),
    const Model(
      Question:"Who is the Founder of Google ?",
      Options:["Steve Jobs","Elon Musk","Bill Gates","Page"],
      Ans:3,
    ),
    const Model(
      Question:"Who is the Founder of Amazon ?",
      Options:["Steve Jobs","Elon Musk","Bill Gates","None"],
      Ans:3,
    ),
  ];

  MaterialStateProperty<Color?> changedColor(int optionindex){
    if(selectedIndex!=-1){
      if(optionindex==allQuestions[index].Ans){
        return const MaterialStatePropertyAll(Colors.green);
      }else if(selectedIndex==optionindex){
        return const MaterialStatePropertyAll(Colors.red);
      }else{
        return const MaterialStatePropertyAll(Colors.grey);
      }
    }else{
      return const MaterialStatePropertyAll(Colors.grey  );
    }
  }

  Scaffold isQuestionScreen(){
    if(questionScreen==true){
      return Scaffold(
        
        appBar: AppBar(
          
          title: const Text(
            'QuizApp',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          backgroundColor: Colors.black54,
          
          centerTitle: true,
        ),

        body: Column(
          
          children: [
            
            const SizedBox(
              height: 80,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                
                const Text(
                  'Question : ',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                Text(
                  "${index+1}/${allQuestions.length}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            Text(
              allQuestions[index].Question,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400
              ),
            ),

            const SizedBox(
              height: 60,
            ),

            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                
                onPressed: (){
                 if(selectedIndex==-1){
                  setState(() {
                    selectedIndex = 0;
                  });
                 }
                },

                style:ButtonStyle(
                  backgroundColor: changedColor(0),
                ),

                child: Text(
                  "A.${allQuestions[index].Options[0]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: (){
                 if(selectedIndex==-1){
                  setState(() {
                    selectedIndex = 1;
                  });
                 }
                },
                style:ButtonStyle(
                  backgroundColor: changedColor(1),
                ),

                child: Text(
                  "B.${allQuestions[index].Options[1]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: (){
                 if(selectedIndex==-1){
                  setState(() {
                    selectedIndex = 2;
                  });
                 }
                },

                style:ButtonStyle(
                  backgroundColor: changedColor(2),
                ),

                child: Text(
                  "C.${allQuestions[index].Options[2]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: (){
                 if(selectedIndex==-1){
                  setState(() {
                    selectedIndex = 3;
                  });
                 }
                },

                style:ButtonStyle(
                  backgroundColor: changedColor(3),
                ),

                child: Text(
                  "D.${allQuestions[index].Options[3]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed:(){
            if(selectedIndex==-1){
              return;
            }

            if(selectedIndex==allQuestions[index].Ans){
              marks += 1;
            }

            selectedIndex=-1;
            if(index==allQuestions.length-1){
              setState(() {
                questionScreen=false;
              });  
            }

            setState(() {
              index++;
            });
          },
          backgroundColor: Colors.black54,
          child: const Icon(Icons.forward), 
        ),
      );

    }else{
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'QuizApp',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.black54,
          centerTitle: true,
        ),

        backgroundColor: Colors.white,
        
        body: Column(
          children: [
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),

            Container(
              alignment: Alignment.center,
              height: 250,
              width: 250,
              color: Colors.white,
              child:  Image.network('https://static.vecteezy.com/system/resources/previews/013/391/041/non_2x/trophy-3d-illustration-free-png.png') 
            ),

            const SizedBox(
              height: 50,
              width: double.infinity,
            ),

            const Text(
              'Congratulations!!!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700
              ),
            ),

            const SizedBox(
              height: 20,
              width: double.infinity,
            ),

            const Text(
              'Quiz Completed',
              style: TextStyle(
                fontSize: 22.5,
                fontWeight: FontWeight.w600
              ),
            ),

            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
  
            Text("Your Score : $marks/${allQuestions.length}",
              style:const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500
              ),
            ),

            const SizedBox(
              height: 20,
              width: double.infinity,
            ),

            ElevatedButton(
              onPressed:(){
                index = 0;
                selectedIndex = -1;
                questionScreen = true;
                marks = 0;
                setState(() {});
              } ,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.black54
                )
              ),  
              child: const Text('Reset',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              )
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return isQuestionScreen();
  }
}