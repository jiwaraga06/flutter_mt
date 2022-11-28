import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButtonLogout extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;
  final Icon? icon;
  final Color? color;
  const ButtonLogout({super.key, this.onPressed, this.text, this.icon,this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              color: color!,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: SizedBox(
              height: 40,
              child: Container(
                decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(8.0)
            ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!,
                    SizedBox(width: 8),
                    Text(
                      '$text',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
