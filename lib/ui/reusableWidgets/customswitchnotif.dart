import 'package:flutter/material.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/ui/main.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class CustomSwitchNotification extends StatefulWidget {
  final VoidCallback callbackON;
  final VoidCallback callbackOFF;
  CustomSwitchNotification(
      {super.key, required this.callbackON, required this.callbackOFF});

  @override
  State<CustomSwitchNotification> createState() => _CustomSwitchNotification();
}

class _CustomSwitchNotification extends State<CustomSwitchNotification> {
  bool switchValue = false;

  @override
  void initState() {
    switchValue = SharedPreferences.shared.isNotificationEnabled;
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
            SharedPreferences.shared.isNotificationEnabled = value;
            value = !value;
            if (SharedPreferences.shared.isNotificationEnabled) {
              widget.callbackON();
            } else {
              widget.callbackOFF();
            }
          });
        });
  }
}
