import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button({required this.text, required this.navigation, super.key});
  final String text;
  final void Function() navigation;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: navigation,
      child: Text(
        text,
        style: GoogleFonts.workSans(fontSize: 15),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor: Color(0xff85CC16),
          foregroundColor: Colors.white),
    );
  }
}
