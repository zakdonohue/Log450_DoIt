import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  State<CustomSwitch> createState() => SwitchState();
}

class SwitchState extends State<CustomSwitch> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
        // This bool value toggles the switch.
        value: light,
        activeColor: Color.fromARGB(95, 6, 97, 41),
        onChanged: (bool value) {
          // This is called when the user toggles the switch.
          setState(() {
            light = value;
          });
        });
  }
}
