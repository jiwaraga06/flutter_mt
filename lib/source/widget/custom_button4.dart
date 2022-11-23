import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomButton4 extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Icon? icon;
  final Color? color;
  const CustomButton4({super.key, this.onPressed, this.text, this.icon,this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
              side: BorderSide(
                color:color!,
                width: 1.5,
              )),
        ),
        child: Ink(
          decoration: BoxDecoration(
            // color: Colors.white
          ),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                SizedBox(width: 8),
                Text(
                  '$text',
                  style: TextStyle(color: color!, fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }
}
