import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class ButtonIcon extends StatelessWidget {
  final String buttonText;
  final String icon;
  final Color textColor;
  static double iconSize = 24.0;

  const ButtonIcon(
      {super.key,
      required this.buttonText,
      required this.icon,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: ElevatedButton.icon(
            onPressed: () {},
            label: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                )),
            icon: Image.asset(icon, width: iconSize, height: iconSize)),
      )
    ]));
  }
}
