// ignore: file_names
import 'package:flutter/material.dart';

class Assignment extends StatefulWidget{
  const Assignment({super.key});
  
  @override
  State<Assignment> createState() => _Assignment();
}

class _Assignment extends State<Assignment>{

    int ?_count = 0;
    bool _flaga = false;
    bool _flagb = false;
    bool _flagc = false;
    bool _flag1 = false;
    bool _flag2 = false;
    bool _flag3 = false;
    bool _flag4 = false;
    bool _flag5 = false;
    bool _flag6 = false;

    double a = 450;
  void _increment(){
    setState(() {
      _count = _count! + 1;
      if(a>=10){
        a = a - 10;
      }else{
        _flag6 = true;
      }
      if(_count==1){
        _flaga = true;
      }
      if(_count==2){
        _flagb = true;
      }
      if(_count==3){
        _flagc = true;
      }
      if(_count==4){
        _flag1 = true;
      }
      if(_count==5){
        _flag2 = true;
      }
      if(_count==6){
        _flag3 = true;
      }
      if(_count==7){
        _flag4 = true;
      }
      if(_count==8){
        _flag5 = true;
      }
      if(_count==9){
        
      }
    });
  }

    @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'India'
          ),
        ),
        body:Column(
          children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 30
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 600,
                        width: 3.5,
                        color:_flag1? Colors.black:Colors.white,
                      ),
                      Column(
                        
                        children: [
                          Container(
                            height: a,
                          ),
                          Container(
                            height: 50,
                            width: 220,
                            color:_flag2? Colors.orange:Colors.white,
                          ),
                          Container(
                            height: 50,
                            width: 220,
                            color:_flag3? Colors.white:Colors.white,
                            child:_flag4? Image.network(
                              "data:image/png;base64,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"
                            ):Container()
                          ),
                          Container(
                            height: 50,
                            width: 220,
                            color:_flag5? Colors.green:Colors.white,
                          ),
                          (_flag6?Container(
                            height: 150,
                          ):Container()
                          ),
                          (_flag6?const Text(
                              'JAI  HIND',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange
                              ),
                            ):
                            Container()
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 0,  
                  )
                ],
              ),
              Column(
                children:[
                  Container(
                    height: 20,
                    width: 100,
                    color:_flagc? Colors.black:Colors.white,
                  ),
                  Container(
                    height: 20,
                    width: 150,
                    color:_flagb? Colors.black:Colors.white,
                  ),
                  Container(
                    height: 20,
                    width: 200,
                    color:_flaga? Colors.black:Colors.white,
                  )
                ]
              )
            ],
          )
          ]
        ),
        floatingActionButton: FloatingActionButton(onPressed:_increment,
        child: const Text('Button'),
        shape: const ContinuousRectangleBorder(),
        backgroundColor: Colors.amber,
        ),
      );
  }
}