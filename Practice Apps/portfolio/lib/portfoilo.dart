import 'package:flutter/material.dart';

class portfolio extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() => _portfolio();
}

class _portfolio extends State<portfolio>{
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( 
        title:const Text(
          'Portfolio',
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            height: 20,
          ),
            const Row(
            children: [
                Text(
                "Name:- Swapnil Andhare",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Container(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 50,
              ),
              Container(
                height: 150,
                width: 150,
                child:Image.asset("assets/images/2.jpg")
              )
            ],
          ),
          Container(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 50,
              ),
              const Text(
                "College:- SKNCOE",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 30,
              ),
              Container(
                height: 200,
                width: 200,
                child:Image.network("https://tse4.mm.bing.net/th?id=OIP.72Lu0ID3FKWYIOrBrSz4EQHaEc&pid=Api&P=0&h=220"),
              )
            ],
          ),
          const Row(
            children: [
              Text(
                "Dream Company:- Microsoft",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 30,
              ),
              Container(
                height: 200,
                width: 200,
                child:Image.network("https://tse2.mm.bing.net/th?id=OIP.00E0zwyOfqXB5nj0r2bvSAHaE1&pid=Api&P=0&h=220"),
              )
            ],
          )
        ],
      ),
    );
  }
}