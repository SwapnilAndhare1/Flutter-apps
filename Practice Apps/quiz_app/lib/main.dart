
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

class _QuizState extends State<Quiz>{
  bool questionScreen = true;
  int index = 0;

  List<Map> allQuestions = [
    {
      "Question":"Who is the Founder of Microsoft ?",
      "Options":["Steve Jobs","Elon Musk","Bill Gates","Page"],
      "Ans":2,
    },
    {
      "Question":"Who is the Founder of Apple ?",
      "Options":["Steve Jobs","Elon Musk","Bill Gates","Page"],
      "Ans":0,
    },
    {
      "Question":"Who is the Founder of Tesla ?",
      "Options":["Steve Jobs","Elon Musk","Bill Gates","Page"],
      "Ans":1,
    },
    {
      "Question":"Who is the Founder of Google ?",
      "Options":["Steve Jobs","Elon Musk","Bill Gates","Page"],
      "Ans":3,
    },
    {
      "Question":"Who is the Founder of Amazon ?",
      "Options":["Steve Jobs","Elon Musk","Bill Gates","None"],
      "Ans":3,
    },
  ];

  Color green = Colors.green;
  Color red = Colors.red;
  bool opt1 = true;
  bool opt2 = true;
  bool opt3 = true;
  bool opt4 = true;

  void change(int x){

  }
  Scaffold isQuestionScreen(){
    if(questionScreen==true){
      if(index==5){
        questionScreen=false;
        return Scaffold(
          appBar: AppBar(
            title: const Text('QuizApp'),
          ),
          body: const Center(
            child: Text(
              'Congralution!!!',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            setState(() {
              index = 1;
            });
            
          },
            child: const Text('Reset'),
          ),

        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'QuizApp',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),

        body: Column(
          children: [
            const SizedBox(
              height: 30,
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
              height: 30,
            ),

            Text(
              allQuestions[index]["Question"],
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w400
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
                  change(0);
                },
                style: opt1?const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.blue)
                ):const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.red)
                ),
                child: Text(
                  "A.${allQuestions[index]["Options"][0]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
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
                  change(1);
                },
                style: opt2?const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.blue)
                ):const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.red)
                ),
                  child: Text(
                  "B.${allQuestions[index]["Options"][1]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
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
                  change(2);
                },
                style: opt3?const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.blue)
                ):const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.red)
                ),
                  child: Text(
                  "C.${allQuestions[index]["Options"][2]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
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
                  change(3);
                },
                style: opt4?const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.blue)
                ):const ButtonStyle(
                  backgroundColor:MaterialStatePropertyAll(Colors.red)
                ),
                  child: Text(
                  "D.${allQuestions[index]["Options"][3]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            setState(() {
              index++;
            });
          },
          child: const Icon(Icons.forward), 
        ),
      );

    }else{
      return const Scaffold();
    }
  }

  @override
  Widget build(BuildContext context){
    return isQuestionScreen();
  }
}