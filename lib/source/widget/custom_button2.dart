import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton2 extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  const CustomButton2({super.key, this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        splashColor: Color(0xFF3282B8),
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                 gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF0F4C75),
                Color(0xFF3282B8),
                Color(0xFFBBE1FA),
              ]
            )
              ),
              child: Text(
                "$text",
                style: GoogleFonts.lato(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              )),
      ),
    );
  }
}