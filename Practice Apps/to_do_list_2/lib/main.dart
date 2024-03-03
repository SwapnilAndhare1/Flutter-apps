import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget{
  const ToDoList({super.key});

  @override
  State createState() => _ToDoList();
}

class _ToDoList extends State{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-do list',
          style: GoogleFonts.quicksand(
                        fontSize: 26,
            fontWeight: FontWeight.w700,

          ),
        ),
        backgroundColor: const Color.fromRGBO(2,167,177,1),
      ),
    );
  }
}