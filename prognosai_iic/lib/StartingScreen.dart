import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prognosai_iic/signup.dart';
import 'package:prognosai_iic/widgets/Button.dart';

class Startingscreen extends StatelessWidget {
  const Startingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset('assets/logo.svg'),
              SizedBox(
                height: 5,
              ),
              Text(
                'PROGNOS',
                style: GoogleFonts.workSans(
                  fontSize: 60,
                ),
              ),
              SvgPicture.asset('assets/tag.svg'),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(20),
                child: Button(
                  text: 'Get Started',
                  navigation: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signup(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
