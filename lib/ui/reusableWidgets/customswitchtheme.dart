import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class CustomSwitchTheme extends StatefulWidget {
  final VoidCallback callbackON;
  final VoidCallback callbackOFF;
  CustomSwitchTheme(
      {super.key, required this.callbackON, required this.callbackOFF});

  @override
  State<CustomSwitchTheme> createState() => _CustomSwitch();
}

class _CustomSwitch extends State<CustomSwitchTheme> {
  bool switchValue = false;
  //bool isDarkMode = false;
  @override
  void initState() {
    switchValue = SharedPreferences.shared.isDarkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: switchValue,
        activeColor: const Color.fromARGB(95, 6, 97, 41),
        onChanged: (bool value) {
          setState(() {
            switchValue = value;
            SharedPreferences.shared.isDarkMode = value;
            value = !value;
            if (SharedPreferences.shared.isDarkMode) {
              widget.callbackON();
            } else {
              widget.callbackOFF();
            }
          });
        });
  }
}
