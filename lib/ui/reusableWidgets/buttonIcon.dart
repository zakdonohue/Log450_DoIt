import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final String buttonText;
  final String icon;
  final Color textColor;
  final String route;
  static const double iconSize = 24.0;

  const ButtonIcon(
      {super.key,
      required this.buttonText,
      required this.icon,
      required this.textColor,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            label: Align(
                alignment: Alignment.center,
                child: Text(
                  buttonText,
                  style:
                      TextStyle(color: textColor, fontWeight: FontWeight.bold),
                )),
            icon: Image.asset(icon, width: iconSize, height: iconSize)),
      )
    ]));
  }
}
