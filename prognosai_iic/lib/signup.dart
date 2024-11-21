// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prognosai_iic/chatScreen.dart';
import 'package:prognosai_iic/login.dart';
import 'package:prognosai_iic/widgets/Button.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signupUser(
      String name, String phone, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user?.uid ?? '';

      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'phone': phone,
        'email': email,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatScreen(
                  name: name,
                )),
      );
    } catch (e) {
      print(e);
    }
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();

    Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.workSans(fontSize: 32),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle:
                        GoogleFonts.workSans(color: Colors.black, fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: phone,
                  decoration: InputDecoration(
                    labelText: 'Emergency Contact No',
                    labelStyle:
                        GoogleFonts.workSans(color: Colors.black, fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle:
                        GoogleFonts.workSans(color: Colors.black, fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        GoogleFonts.workSans(color: Colors.black, fontSize: 16),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF85CC16), width: 2.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Button(
                    text: 'Sign Up',
                    navigation: () {
                      _signupUser(
                          name.text, phone.text, email.text, password.text);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: GoogleFonts.workSans(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.workSans(
                          color: Color(0xFF16A85C),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
