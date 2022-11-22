import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormField extends StatelessWidget {
  final String? hint, label,msgError;
  final TextEditingController? controller;
  final Icon? iconLock;
  final VoidCallback? showPass;
  final bool? iconPass;
  final TextInputType? inputType;
  CustomFormField({
    super.key,
    this.hint,
    this.inputType,
    this.label,
    this.controller,
    this.iconLock,
    this.showPass,
    this.iconPass,
    this.msgError,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Color(0xFF0D4C92),
      keyboardType: inputType,
      style: GoogleFonts.lato(),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        errorStyle: GoogleFonts.lato(
          fontSize: 15
        ),
        labelStyle: GoogleFonts.lato(
          color: Color(0xFF0D4C92),
        ),
        hintStyle: GoogleFonts.lato(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Color(0xFF0D4C92),
            width: 2,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        
      ),
      validator: (value){
        if(value == null || value.isEmpty){
          return msgError;
        }
        return null;
      },
    );
  }
}