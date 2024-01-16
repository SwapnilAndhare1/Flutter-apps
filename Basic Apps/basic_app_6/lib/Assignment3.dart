import 'package:flutter/material.dart';

class Assignment3 extends StatefulWidget{
  const Assignment3({super.key});

  @override
  State<Assignment3> createState() => _Assignment3State();
}

class _Assignment3State extends State<Assignment3>{
  int? selectedIndex = 0;
  final List<int> imageList = [121,2233,3333,565,153,145];
    void showNextImage(){
      setState(() {
        selectedIndex=selectedIndex!+1;
      });
    }
    int ans = 0;
    int pallindrome(List<int> al){
      int count = 0;
      for(int i = 0;i<al.length;i++){
        int temp1 = al.elementAt(i);
        int temp2 = 0;
        while(temp1>0){
          int rem = temp1 % 10;
          temp2 = (temp2 * 10) + rem;
          temp1 = temp1 ~/ 10; 
        }
        if(temp2==al.elementAt((i))){
          count++;
        }
      }
      ans = count;
      return count;
    }
    int ans1 = 0;
    int armstrong(List<int> al){
      int count = 0;
      for(int i = 0;i<al.length;i++){
        int temp1 = al.elementAt(i);
        int temp2 = temp1;
        int temp3 = 0;
        int count1 = 0;
        while(temp1>0){
          count1++;
          temp1 = temp1 ~/ 10;
        }
    
        while(temp2>0){
          int rem = temp2%10;
          int mult = 1;
          for(int j = 1;j<=count1;j++){
            mult = mult * rem;
          }
          temp3 = temp3 + mult;
          temp2 = temp2 ~/ 10;
        }
        if(temp3==al.elementAt(i)){
          count++;
        }
      }
      ans1 = count;
        return ans;
    }

    int ans2 = 0;
    int strong(List<int> al){
      int count = 0;
      for(int i = 0;i<al.length;i++){
        int temp1 = al.elementAt(i);
        int temp2 = 0;
        while(temp1>0){
          int rem = temp1%10;
          int mult = 1;
          while(rem>=1){
            mult = mult * rem--;
          }
          temp2 = temp2 + mult;
          temp1 = temp1 ~/ 10;
        }
        if(temp2==al.elementAt(i)){
          count++;
        }
      }
      ans2 = count;
      return count;
    }
    void Demo(){
      pallindrome(imageList);
      setState(() {
        selectedIndex = selectedIndex! + 1;
      });
    }
    void Demo2(){
      armstrong(imageList);
      setState(() {
        selectedIndex = selectedIndex! + 1;
      });
    }
    void Demo3(){
      strong(imageList);
      setState(() {
        
      });
    }
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: const Text('Number System'),
          backgroundColor: Colors.black,
        ),

        body: Center(
          child: Column(children: [
            const SizedBox(
              height: 180,
            ),
        
            Text(
              "Count of Pallindrome Number  "
              "$ans"
            ),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(onPressed: Demo, child: const Text('Next'),
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
            ),

            const SizedBox(height: 80,),

            Text(
              "Count of Armstrong Number  "
              "$ans1"
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: Demo2, child: const Text('Next') ,
             style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
            ),

            const SizedBox(
              height: 80,
            ),

            Text(
              "Count of Strong Number  "
              "$ans2"
            ),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: Demo3, child: const Text('Next'), 
             style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
            ),
          ],)
        )
      );
    }
}