import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:lottie/lottie.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  static const routeName = '/loader';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(199, 97, 160, 111)),
        //TODO change for right animation
        body: Center(child: Lottie.asset('assets/LoaderTask.json')));
  }
}

final createMaterialColor = CreateMaterialColor();
