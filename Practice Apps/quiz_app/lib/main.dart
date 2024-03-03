// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State createState() => _QuizState();
}

class Model {
  final String? Question;
  final List<String> Options;
  final int? Ans;

  const Model({this.Question, required this.Options, this.Ans});
}

class _QuizState extends State<Quiz> {
  bool questionScreen = true;
  int index = 0;
  int selectedIndex = -1;
  int marks = 0;

  List allQuestions = [
    const Model(
      Question: "What is chemical Symbol for gold?",
      Options: ["Au", "Ag", "Fe", "Pb"],
      Ans: 0,
    ),
    const Model(
      Question: "What is the capital of Australia?",
      Options: ["Sydney", "Melbourne", "Canberra", "Perth"],
      Ans: 2,
    ),
    const Model(
      Question: "Which is the 'Red Planet'?",
      Options: ["Jupiter", "Venus", "Mars", "Saturn"],
      Ans: 2,
    ),
    const Model(
      Question: "Which is the largest ocean on Earth?",
      Options: [
        "Atlantic Ocean",
        "Antartic Ocean",
        "Arctic Ocean",
        "Pacific Ocean"
      ],
      Ans: 3,
    ),
    const Model(
      Question: "Which planet is closest to sun?",
      Options: ["Mars", "Venus", "Jupiter", "Mercury"],
      Ans: 3,
    ),
  ];

  MaterialStateProperty<Color?> changedColor(int optionindex) {
    if (selectedIndex != -1) {
      if (optionindex == allQuestions[index].Ans) {
        return const MaterialStatePropertyAll(Color.fromARGB(255, 11, 185, 17));
      } else if (selectedIndex == optionindex) {
        return const MaterialStatePropertyAll(Color.fromARGB(255, 227, 20, 5));
      } else {
        return const MaterialStatePropertyAll(Colors.black54);
      }
    } else {
      return const MaterialStatePropertyAll(Colors.black54);
    }
  }

  int temp = 0;
  Scaffold isQuestionScreen() {
    if (temp == 0) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
              width: double.infinity,
            ),
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.white,
              child: Image.network(
                  'https://img.freepik.com/premium-vector/quiz-logo-with-speech-bubble-icon_149152-811.jpg'),
            ),
            const Text(
              'The Quiz App',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 45,
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  temp++;
                  setState(() {});
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black54)),
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 250,
            ),
            const Text(
              'Swapnil Andhare',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ),
      );
    }
    if (questionScreen == true) {
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
                  "${index + 1}/${allQuestions.length}",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              allQuestions[index].Question,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 50,
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 0;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: changedColor(0),
                ),
                child: Text(
                  "A.${allQuestions[index].Options[0]}",
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 1;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: changedColor(1),
                ),
                child: Text(
                  "B.${allQuestions[index].Options[1]}",
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 2;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: changedColor(2),
                ),
                child: Text(
                  "C.${allQuestions[index].Options[2]}",
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedIndex == -1) {
                    setState(() {
                      selectedIndex = 3;
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: changedColor(3),
                ),
                child: Text(
                  "D.${allQuestions[index].Options[3]}",
                  style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedIndex == -1) {
              return;
            }

            if (selectedIndex == allQuestions[index].Ans) {
              marks += 1;
            }

            selectedIndex = -1;
            if (index == allQuestions.length - 1) {
              setState(() {
                questionScreen = false;
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
    } else if (marks > 2) {
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
                child: Image.network(
                    'https://static.vecteezy.com/system/resources/previews/013/391/041/non_2x/trophy-3d-illustration-free-png.png')),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            const Text(
              'Congratulations!!!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            const Text(
              'Quiz Completed',
              style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Text(
              "Your Score : $marks/${allQuestions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            ElevatedButton(
                onPressed: () {
                  index = 0;
                  selectedIndex = -1;
                  questionScreen = true;
                  marks = 0;
                  temp = 0;
                  setState(() {});
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black54)),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      );
    } else {
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
                child: Image.network(
                    'https://tse1.mm.bing.net/th?id=OIP.9L2I5L9afLq7fW0Awmg_8AHaHa&pid=Api&P=0&h=220')),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            const Text(
              'Fail',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            const Text(
              'Quiz Completed',
              style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            Text(
              "Your Score : $marks/${allQuestions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            ElevatedButton(
                onPressed: () {
                  index = 0;
                  selectedIndex = -1;
                  questionScreen = true;
                  marks = 0;
                  temp = 0;
                  setState(() {});
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black54)),
                child: const Text(
                  'Reset',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isQuestionScreen();
  }
}
