// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:prognosai_iic/chatScreen.dart';
import 'package:prognosai_iic/signup.dart';
import 'package:prognosai_iic/widgets/Button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String? userName =
          await _getUserNameFromFirestore(userCredential.user?.uid ?? '');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(name: userName),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _getUserNameFromFirestore(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (doc.exists) {
      return doc.get('name');
    } else {
      return null;
    }
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
                      'Login',
                      style: GoogleFonts.workSans(fontSize: 32),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                  controller: _passwordController,
                  obscureText: true,
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
                    text: 'Login',
                    navigation: _loginUser,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create an account!',
                      style: GoogleFonts.workSans(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      child: Text(
                        'Signup',
                        style: GoogleFonts.workSans(color: Color(0xFF16A85C)),
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
