import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State {
  List<int> list = [];
  int count = 0;

  void _increment() {
    setState(() {
      list.add(count++);
    });
  }

  Color change(int count) {
    if (count % 4 == 0) {
      return const Color.fromRGBO(250, 232, 232, 1);
    } else if (count % 4 == 1) {
      return const Color.fromRGBO(232, 237, 250, 1);
    } else if (count % 4 == 2) {
      return const Color.fromRGBO(250, 249, 232, 1);
    } else {
      return const Color.fromRGBO(250, 232, 250, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'To-do list',
            style: GoogleFonts.quicksand(
                color: const Color.fromRGBO(255, 255, 255, 1),
                fontSize: 26.0,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: false,
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 120,
                width: 330,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        spreadRadius: 1)
                  ],
                  color: change(index),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 52,
                          width: 52,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 0,
                                color: Color.fromRGBO(0, 0, 0, 0.07),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.image_sharp),
                        ),
                        Text(
                          '10 July 2023',
                          style: GoogleFonts.quicksand(
                              color: const Color.fromRGBO(132, 132, 132, 1),
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 17,
                          width: 270,
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            'Lorem Ipsum is simply setting industry. ',
                            style: GoogleFonts.quicksand(
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 44,
                          width: 270,
                          margin: const EdgeInsets.all(5),
                          child: Text(
                            'Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s ',
                            style: GoogleFonts.quicksand(
                                color: const Color.fromRGBO(84, 84, 84, 1),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Color.fromRGBO(0, 139, 148, 1),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.delete,
                                color: Color.fromRGBO(0, 139, 148, 1))
                          ],
                        )
                      ],
                    )
                  ],
                )
              );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _increment,
          backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}