// ignore: file_names
import 'package:flutter/material.dart';

class Dominos extends StatefulWidget{
  const Dominos({super.key});

  @override
  State createState() => _DominosState();
}

class _DominosState extends State<Dominos>{
  bool flag = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.grey,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25)
          )
        ),
        title: flag?const Text('Domino`s'):const Text('Pizza'),
        backgroundColor: Colors.deepPurple,
      ),

      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            '  What are you craving for?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: Image.network('https://tse2.mm.bing.net/th?id=OIP.yLIfEjXySueliD1jyN9QJAHaGB&pid=Api&P=0&h=220'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Love-Loaded Menu',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: Image.network('https://tse2.mm.bing.net/th?id=OIP.Ies3ov-btDTHU6hq8YjKJQAAAA&pid=Api&P=0&h=220'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Garlic Breads & More',
                      style: TextStyle(
                      fontWeight: FontWeight.w500
                    )
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: Image.network('https://tse3.mm.bing.net/th?id=OIP.Uu-joAhjCCgTIF_VZi426QAAAA&pid=Api&P=0&h=220'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Veg Pizza',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: Image.network('https://tse2.mm.bing.net/th?id=OIP.yLIfEjXySueliD1jyN9QJAHaGB&pid=Api&P=0&h=220'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Pizza Mania',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    )
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: Image.network('https://tse3.mm.bing.net/th?id=OIP.ra10pCjsQVB7BEUrVuUwTAAAAA&pid=Api&P=0&h=220'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Non-Veg Pizza',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.white,
                    child: Image.network('https://tse3.mm.bing.net/th?id=OIP.ra10pCjsQVB7BEUrVuUwTAAAAA&pid=Api&P=0&h=220'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Value Combos',
                    style: TextStyle(
                      fontWeight: FontWeight.w500
                    )
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'TOP 10 Bestsellers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.white,
                      child: Image.network(
                        'https://tse1.mm.bing.net/th?id=OIP.Q5-bJXsO6HfQJgyBLAHQ2QHaFF&pid=Api&P=0&h=220'   
                      ),
                    ),
                    ElevatedButton(
                      
                      onPressed: (){},
                      style: const ButtonStyle(
                        mouseCursor: MaterialStatePropertyAll(MaterialStateMouseCursor.clickable),
                        backgroundColor:MaterialStatePropertyAll(Colors.deepPurple)
                      ),
                      child: const Icon(Icons.add)
                    )
                  ],
                ),Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.white,
                      child: Image.network(
                        'https://tse1.mm.bing.net/th?id=OIP.Q5-bJXsO6HfQJgyBLAHQ2QHaFF&pid=Api&P=0&h=220'   
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Colors.deepPurple)
                      ),
                      child: const Icon(Icons.add)
                    )
                  ],
                ),Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.white,
                      child: Image.network(
                        'https://tse1.mm.bing.net/th?id=OIP.Q5-bJXsO6HfQJgyBLAHQ2QHaFF&pid=Api&P=0&h=220'   
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Colors.deepPurple)
                      ),
                      child: const Icon(Icons.add)
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              'Popular Veg Delights',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.white,
                      child: Image.network(
                        'https://tse3.mm.bing.net/th?id=OIP.W1sFSVWlWFbrexrzio-vKQHaHc&pid=Api&P=0&h=220'    
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Colors.deepPurple)
                      ),
                      child: const Icon(Icons.add)
                    )
                  ],
                ),Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.white,
                      child: Image.network(
                        'https://tse3.mm.bing.net/th?id=OIP.W1sFSVWlWFbrexrzio-vKQHaHc&pid=Api&P=0&h=220'  
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Colors.deepPurple)
                      ),
                      child: const Icon(Icons.add)
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 200,
                      width: 300,
                      color: Colors.white,
                      child: Image.network(
                        'https://tse3.mm.bing.net/th?id=OIP.W1sFSVWlWFbrexrzio-vKQHaHc&pid=Api&P=0&h=220'  
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){},
                      style: const ButtonStyle(
                        backgroundColor:MaterialStatePropertyAll(Colors.deepPurple)
                      ),
                      child: const Icon(Icons.add)
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          flag = !flag;
        });
      },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.local_pizza_sharp),
      ),
    );
  }
}