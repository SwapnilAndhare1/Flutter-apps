// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Portfolio(),
    );
  }
}

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}
List<Container> al = [];
class _PortfolioState extends State<Portfolio> {
  final TextEditingController candidateName = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController companyAddress = TextEditingController();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  bool displayFlag = false;

  /*void _printData(){
    print('Company name : ${candidateName.text}');
    print('Company name : ${companyName.text}');
    print('Company name : ${companyAddress.text}');
  }
  @override
  void initState() {
    super.initState();
    candidateName.addListener(_printData);
    companyName.addListener(_printData);
    companyAddress.addListener(_printData);
  }*/
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Portfolio',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(9, 186, 189, 0.4),
        ),
        body: Column(
          children: [
            Container(
                height: 410,
            
                width: double.infinity,
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' Candidate Name : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 60,
                        width: 223,
                        child: TextField(
                          onTap: () {
                            displayFlag = false;
                            setState(() {});
                          },
                          controller: candidateName,
                          cursorColor: Colors.black,
                          cursorOpacityAnimates: true,
                          decoration: const InputDecoration(
                              hintText: 'Enter Your Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              )),
                          onSubmitted: (value) {
                            _focusNode1.unfocus();
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' Company Name : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 60,
                        width: 228,
                        child: TextField(
                          onTap: () {
                            displayFlag = false;
                            setState(() {});
                          },
                          keyboardType: TextInputType.name,
                          controller: companyName,
                          cursorColor: Colors.black,
                          cursorOpacityAnimates: true,
                          decoration: const InputDecoration(
                              hintText: 'Enter Company Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              )),
                          onSubmitted: (value) {
                            _focusNode2.unfocus();
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' Company Addrs : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 60,
                        width: 230,
                        child: TextField(
                          onTap: () {
                            displayFlag = false;
                            setState(() {});
                          },
                          keyboardType: TextInputType.streetAddress,
                          controller: companyAddress,
                          cursorColor: Colors.black,
                          cursorOpacityAnimates: true,
                          decoration: const InputDecoration(
                              hintText: 'Enter Company Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              )),
                          onSubmitted: (value) {
                            _focusNode3.unfocus();
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    width: 140,
                    child: ElevatedButton.icon(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(9, 186, 189, 0.4)),
                      ),
                      label: const Text(
                        'Portfoilo',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      icon: const Icon(Icons.smart_display_sharp),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        displayFlag = true;
                        al.add(Container(
                          height: 70,
                          width: 70,
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color:  Color.fromRGBO(9, 186, 189, 0.2),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Column(
                            children: [
                              Text('${candidateName.text}'),
                              Text('${companyName.text}'),
                              Text('${companyAddress.text}')
                            ],
                          ),
                        ));
                        setState(() {});
                      },
                    ),
                  ),
                ]
              )
            ),
            Expanded(child: half())
          ],
        )
      );
  }
}

class half extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 400,
            width: 60,
            child: ListView.builder(
              itemCount: al.length,
              itemBuilder: (context, index) {
                return al.elementAt(index);
              },
            ),
          ),
        )
      ],
    );
  }
}