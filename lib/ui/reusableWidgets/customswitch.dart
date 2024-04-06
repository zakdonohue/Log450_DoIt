import 'package:flutter/material.dart';
import 'package:log450_doit/ui/main.dart';

class CustomSwitch extends StatefulWidget {
  final VoidCallback callbackON;
  final VoidCallback callbackOFF;
  CustomSwitch(
      {super.key, required this.callbackON, required this.callbackOFF});

  @override
  State<CustomSwitch> createState() => SwitchState();
}

class SwitchState extends State<CustomSwitch> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: switchValue,
        activeColor: const Color.fromARGB(95, 6, 97, 41),
        onChanged: (bool value) {
          switchValue = value;
          setState(() {
            if (switchValue) {
              widget.callbackON();
            } else {
              widget.callbackOFF();
            }
          });
        });
  }
}
