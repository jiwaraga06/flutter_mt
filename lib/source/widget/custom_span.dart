import 'package:flutter/material.dart';

class CustomSpan extends StatelessWidget {
  final String? text;
  final Color? color;
  const CustomSpan({super.key, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: color!,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        text!,
        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
