import 'package:flutter/material.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget{
  const MainApp({super.key});

  @override
  Widget build (BuildContext context){
    return MaterialApp(
      title:'Netflix',
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          title: const Text('NETFLIX'),
          backgroundColor: Colors.red,
        ),
        body: ListView(
          children:[
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Movies',
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bgCCCCCC/et00311762-lmdexnggxy-portrait.jpg",
                      height: 400,
                      width: 200,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bgCCCCCC/et00311762-lmdexnggxy-portrait.jpg",
                      height: 400,
                      width: 200,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bgCCCCCC/et00311762-lmdexnggxy-portrait.jpg",
                      height: 400,
                      width: 200,
                    ),
                    
                  ],
                ),
                ),
                Text(
                  'WEB SERIES'
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://tse4.mm.bing.net/th?id=OIP.nxTx4M8rOw_0yj7EtcNlGwHaLH&pid=Api&P=0&h=220",
                      height: 250,
                      width: 150,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://tse4.mm.bing.net/th?id=OIP.jbrj49f99tHFAVuhQdGelgHaJQ&pid=Api&P=0&h=220",
                      height: 250,
                      width: 150,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://dbdzm869oupei.cloudfront.net/img/posters/preview/91008.png",
                      height: 250,
                      width: 150,
                    ),
                  ],                
                ),
                ),
                Text(
                  'MOST POPULAR'
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                 child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://i.pinimg.com/736x/0e/cc/15/0ecc1542dbeaa1c475a60d5bb4c60a76.jpg",
                      height: 250,
                      width: 150,
                    ),const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://tse4.mm.bing.net/th?id=OIP.JRCKKGEjEA0wvpZjaZkLRAHaIp&pid=Api&P=0&h=220",
                      height: 250,
                      width: 150,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.network("https://dbdzm869oupei.cloudfront.net/img/posters/preview/91008.png",
                      height: 250,
                      width: 150,
                    ),
                  ],                 
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  } 
}