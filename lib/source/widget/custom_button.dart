import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  const CustomButton({super.key, this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
            // begin: Alignment.topLeft,
            // end: Alignment.topRight,
            colors: [
              Color(0xFF0F4C75),
              Color(0xFF3282B8),
              Color(0xFFBBE1FA),
            ],
          ),
        ),
        child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
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
