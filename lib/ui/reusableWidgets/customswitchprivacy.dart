import 'package:flutter/material.dart';
import 'package:log450_doit/ui/main.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class CustomSwitchPrivacy extends StatefulWidget {
  final VoidCallback callbackON;
  final VoidCallback callbackOFF;
  CustomSwitchPrivacy(
      {super.key, required this.callbackON, required this.callbackOFF});

  @override
  State<CustomSwitchPrivacy> createState() => _CustomSwitchPrivacy();
}

class _CustomSwitchPrivacy extends State<CustomSwitchPrivacy> {
  bool switchValue = false;

  @override
  void initState() {
    switchValue = SharedPreferences.shared.isAccountPrivate;
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
            SharedPreferences.shared.isAccountPrivate = value;
            value = !value;
            if (SharedPreferences.shared.isAccountPrivate) {
              widget.callbackON();
            } else {
              widget.callbackOFF();
            }
          });
        });
  }
}
