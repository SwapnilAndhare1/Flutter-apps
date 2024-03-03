import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Color> listOfColors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];

  List<ToDoModal> todoList = [
    ToDoModal(
        title: "Take Notes ",
        description: "Take notes of every app you write",
        date: "10 July 2023"),
    ToDoModal(
        title: "Arrange Meeting",
        description:
            "Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team Meet the backend team",
        date: "10 July 2023")
  ];

  void showSheet(bool doedit, [ToDoModal? toDoModelObj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Create Task',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w600, fontSize: 22),
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Title',
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: const Color.fromRGBO(0, 139, 148, 1)),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: titleController,
                      cursorColor: const Color.fromRGBO(0, 139, 148, 1),
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'Enter Title',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 2.5,
                              color: Color.fromRGBO(0, 139, 148, 1),
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.deepPurple,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Description',
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: const Color.fromRGBO(0, 139, 148, 1)),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500, fontSize: 15),
                      cursorColor: const Color.fromRGBO(0, 139, 148, 1),
                      decoration: InputDecoration(
                          hintText: 'Enter Details',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2.5,
                                color: Color.fromRGBO(0, 139, 148, 1),
                              )),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.purpleAccent,
                              ),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Date',
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: const Color.fromRGBO(0, 139, 148, 1)),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.w500, fontSize: 15),
                      cursorColor: const Color.fromRGBO(0, 139, 148, 1),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025));

                        String formatedDate =
                            DateFormat.yMMMd().format(pickeddate!);
                        setState(() {
                          dateController.text = formatedDate;
                        });
                      },
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.date_range_rounded,
                            color: Color.fromRGBO(0, 0, 0, 0.7),
                          ),
                          hintText: 'Enter Date',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 2.5,
                                color: Color.fromRGBO(0, 139, 148, 1),
                              )),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.purpleAccent,
                              ),
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 139, 148, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 10,
                          spreadRadius: 1,
                          color: Color.fromRGBO(0, 0, 0, 0.1),
                        )
                      ]),
                  child: ElevatedButton(
                    onPressed: () {
                      doedit ? submit(doedit, toDoModelObj) : submit(doedit);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 27,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }

  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void submit(bool doedit, [ToDoModal? obj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doedit) {
        setState(() {
          todoList.add(ToDoModal(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim()));
        });
      } else {
        setState(() {
          obj!.title = titleController.text;
          obj.description = descriptionController.text;
          obj.date = dateController.text;
        });
      }
    }
    clearController();
  }

  void delete(ToDoModal obj) {
    setState(() {
      todoList.remove(obj);
    });
  }

  void edit(ToDoModal obj) {
    titleController.text = obj.title;
    descriptionController.text = obj.description;
    dateController.text = obj.date;

    showSheet(true, obj);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'To-do list',
          style: GoogleFonts.quicksand(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            shadows: const [
              Shadow(color: Colors.black54, offset: Offset(3, 3), blurRadius: 3)
            ],
            letterSpacing: 1.4,
          ),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 0),
            child: Container(
              width: 330,
              height: 165,
              decoration: BoxDecoration(
                  color: listOfColors[index % listOfColors.length],
                  border: Border.all(
                    width: 2,
                    color: Colors.black
                  ),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(5, 10),
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: Color.fromRGBO(0, 0, 0, 0.1))
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                          height: 65,
                          width: 65,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(255, 255, 255, 1),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    color: Color.fromRGBO(0, 0, 0, 0.07))
                              ]),
                          child: ClipOval(
                            child: Image.network(
                              'https://tse4.mm.bing.net/th?id=OIP.G0Fetc161xkDOJ8djd8ZmQHaHa&pid=Api&P=0&h=220',
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 20,
                          width: 255,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(4)),
                          child: SingleChildScrollView(
                            child: Text(
                              todoList[index].title,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 80,
                          width: 255,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(7)),
                          child: SingleChildScrollView(
                            child: Text(
                              todoList[index].description,
                              style: GoogleFonts.quicksand(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        alignment: Alignment.center,
                        height: 20,
                        width: 92,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Text(
                          todoList[index].date,
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            // color: const Color.fromRGBO(132, 132, 132, 1)
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        edit(todoList.elementAt(index));
                      },
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        delete(todoList.elementAt(index));
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    )
                  ],
                )
              ]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clearController();
          showSheet(false);
        },
        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
        child: const Icon(
          Icons.add,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ToDoModal {
  String title;
  String description;
  String date;

  ToDoModal({required this.title, required this.description, required this.date});
}
