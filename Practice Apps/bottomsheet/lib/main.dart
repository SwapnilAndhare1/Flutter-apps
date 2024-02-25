import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Assignment(),
    );
  }
}

class Assignment extends StatefulWidget {
  const Assignment({super.key});
  @override
  State<Assignment> createState() => _Assignment();
}

class _Assignment extends State<Assignment> {
  List colorcon = [
    const Color.fromRGBO(246, 224, 224, 1),
    const Color.fromRGBO(224, 230, 245, 1),
    const Color.fromRGBO(245, 224, 245, 1),
    const Color.fromRGBO(242, 220, 220, 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do list"),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: ListView.builder(
            itemCount: colorcon.length,
            itemBuilder: (context, index) {
              return Container(
                height: 112,
                width: 330,
                decoration: BoxDecoration(
                  color: colorcon[index % colorcon.length],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      Container(
                        height: 70,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(width: 3),
                        ),
                        child: Image.asset("assets/image1.jpeg"),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 15,
                              width: 243,
                              child: Text(
                                  "Lorem Ipsum is simply setting industry. "),
                            ),
                            Container(
                              height: 65,
                              width: 300,
                              child: Text(
                                  "Simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"),
                            ),
                          ])
                    ]),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("11/05/2001"),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      SizedBox(height: 15,),
                      Text("Create task",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "enter name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "company name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Location",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          icon: Icon(Icons.add),
        ),
        backgroundColor: Color.fromRGBO(0, 139, 148, 1),
      ),
    );
  }
}