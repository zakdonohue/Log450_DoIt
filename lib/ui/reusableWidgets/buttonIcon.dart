import 'package:flutter/material.dart';

class ButtonIcon extends StatefulWidget {
  final String buttonText;
  final String icon;
  final Color textColor;
  final String route;
  final Future<void>? callback;

  const ButtonIcon(
      {super.key,
      required this.buttonText,
      required this.icon,
      required this.textColor,
      required this.route,
      this.callback});
  @override
  State<ButtonIcon> createState() => _ButtonIcon();
}

class _ButtonIcon extends State<ButtonIcon> {
  // final String buttonText;
  // final String icon;
  // final Color textColor;
  // final String route;
  // final Future<void>? callback;

  static const double iconSize = 24.0;

  // const ButtonIcon(
  //     {super.key,
  //     required this.buttonText,
  //     required this.icon,
  //     required this.textColor,
  //     required this.route,
  //     this.callback});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: ElevatedButton.icon(
            onPressed: () =>
                {Navigator.pushNamed(context, widget.route), widget.callback},
            label: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.buttonText,
                  style: TextStyle(
                      color: widget.textColor, fontWeight: FontWeight.bold),
                )),
            icon: Image.asset(widget.icon, width: iconSize, height: iconSize)),
      )
    ]));
  }
}
