import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(232, 237, 250, 0.9),
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: GoogleFonts.quicksand(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 25,
              wordSpacing: 5),
        ),
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network('https://cdn1.iconfinder.com/data/icons/elevator/154/elevator-user-man-ui-round-login-1024.png',
                height: 100,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Enter Username or E-mail',
                        hintStyle: GoogleFonts.quicksand(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            wordSpacing: 1),
                        labelText: 'Username',
                        labelStyle: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            wordSpacing: 0),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(width: 1.5)))),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                    obscureText: flag,
                    obscuringCharacter: '*',
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              flag = !flag;
                            });
                          },
                          child: Icon(
                            color: flag ? Colors.black : Colors.red,
                            Icons.remove_red_eye_outlined,
                          ),
                        ),
                        hintText: 'Enter Password',
                        hintStyle: GoogleFonts.quicksand(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            wordSpacing: 0),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.quicksand(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            wordSpacing: 5),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(width: 1.5)))),
              ),
              Container(
                height: 50,
                width: 140,
                child: ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(2, 167, 177, 1))
                  ),
                  child: Text('Login',
                      style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          wordSpacing: 5)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
