import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State createState() => _todo();
}

class _todo extends State {
  List<Container> al = [];

  Color? check(int count) {
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

  void _increment() {
    setState(() {});
    al.add(Container(
      height: 112,
      width: 330,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          boxShadow: const[
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 1,
            )
          ],
          color: check(al.length),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.07))
                    ]),
                child: const Icon(Icons.image),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 25,
                    width: 243,
                    child: const Text(
                      'Lorem Ipsum is simply setting industry. ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    height: 44,
                    width: 243,
                    child: const Text(
                      'Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(84, 84, 84, 1)),
                    ),
                  ),
                ],
              )
            ],
          ),
          const Row(
            children: [
              SizedBox(
                width: 25,
              ),
              SizedBox(
                height: 15,
                width: 70,
                child: Text(
                  '10 July 2023',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(132, 132, 132, 1)),
                ),
              ),
              Spacer(),
              Icon(
                Icons.edit,
                color: Color.fromRGBO(0, 139, 148, 1),
              ),
              Icon(Icons.delete, color: Color.fromRGBO(0, 139, 148, 1))
            ],
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'To-do list',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Color.fromRGBO(255, 255, 255, 1)),
          ),
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        ),
        body: ListView.builder(
            itemCount: al.length,
            itemBuilder: (context, index) {
              return al.elementAt(index);
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: _increment,
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
