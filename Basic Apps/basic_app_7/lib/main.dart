import 'package:flutter/material.dart';
//import 'package:image_app/post_card.dart'

class Assignment4 extends StatefulWidget{
  const Assignment4({super.key});

  @override
  State<Assignment4> createState() => _Assignment4State();
}

class _Assignment4State extends State<Assignment4>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instagram",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          const Icon(
            Icons.favorite_rounded,
            color:Colors.red,
          )
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://tse3.mm.bing.net/th?id=OIP.nqzFwQqc2tvtdCHjOXLBiAHaEK&pid=Api&P=0&h=220",
                width: double.infinity,
              ),
              Row(
                children: [
                  IconButton(onPressed: (){}, 
                    icon: const Icon(
                      Icons.favorite_outline_outlined,
                    ),
                  ),
                  IconButton(onPressed: (){}, 
                    icon: const Icon(
                      Icons.comment_outlined,
                    ),
                  ),
                  IconButton(onPressed: (){}, 
                    icon: const Icon(
                      Icons.send,
                    ),
                  )
                ],
              )
            ],
          )
        ]
      ),
    );
  }
}