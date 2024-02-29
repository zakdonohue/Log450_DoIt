import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  ButtonIcon(this.buttonText, this.icon);

  final String buttonText;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset(icon),
                label: Text(buttonText),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    minimumSize: Size(100.0, 100.0),
                    maximumSize: Size(200.0, 200.0)))));
  }
}
