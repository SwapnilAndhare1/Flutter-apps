import 'package:flutter/material.dart';

class portfolio extends StatefulWidget{
  const portfolio({super.key});

  @override
  State<portfolio> createState() => _portfolio();
}

class _portfolio extends State<portfolio>{
  int counter = 0;

  void increment(){
    setState(() {
      counter = counter + 1;
    });
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar( 
        title:const Text(
          'PORTFOLIO',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          (counter>=1)? const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
                "Name:- Swapnil Andhare",
                style: TextStyle(
                  fontSize: 25,
                ),
              )
            ],
          ):Container(
            color: Colors.white,
            height: 0,
            width: 0,
          ),

          (counter>=2)?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                color: Colors.white,
                child:Image.asset("assets/images/2.jpg"),
              )
            ],
          ):Container(
            color: Colors.white,
            height: 0,
            width: 0,
          ),
          (counter>=3)?const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
                "College:- SKNCOE",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ):Container(height: 0),

          (counter>=4)?Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 200,
                width: 200,
                child:Image.network("https://tse4.mm.bing.net/th?id=OIP.72Lu0ID3FKWYIOrBrSz4EQHaEc&pid=Api&P=0&h=220"),
              )
            ],
          ):Container(height: 0,),

          (counter>=5)?const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Dream Company:- Microsoft",
                style: TextStyle(
                  fontSize: 25,
                ),
              )
            ],
          ):Container(
            height: 0,
          ),
          (counter>=6)? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 200,
                width: 200,
                child:Image.network("https://tse2.mm.bing.net/th?id=OIP.00E0zwyOfqXB5nj0r2bvSAHaE1&pid=Api&P=0&h=220"),
              )
            ],
          ):Container(
            height: 0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: increment,
        mini: false,
        mouseCursor:MaterialStateMouseCursor.clickable,
        backgroundColor: Colors.black,
        splashColor: Colors.amber,
        foregroundColor: Colors.amber,
        hoverColor: Colors.green,
        focusColor: Colors.pink,
        child: const Text("+")),
    );
  }
}