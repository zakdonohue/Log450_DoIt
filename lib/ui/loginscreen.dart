import 'package:flutter/material.dart';
import 'package:log450_doit/ui/createaccountscreen.dart';
import 'package:log450_doit/ui/homecsreen.dart';
import 'package:log450_doit/ui/reusableWidgets/buttonIcon.dart';
import 'package:log450_doit/ui/utils/MaterialColor.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: createMaterialColor
          .createMaterialColor(const Color.fromARGB(200, 97, 115, 160)),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Image.asset('assets/doit.webp'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Entrez le nom d'identifiant"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Entrez le mot de passe"),
                  ),
                )
              ]),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: Column(children: [
                  ButtonIcon(
                      buttonText: "Creer un compte",
                      icon: 'assets/createaccounticon.png',
                      textColor: createMaterialColor.createMaterialColor(
                          const Color.fromARGB(200, 255, 45, 108)),
                      route: CreateAccountScreen.routeName),
                  ButtonIcon(
                      buttonText: "Se connecter",
                      icon: 'assets/loginicon.png',
                      textColor: createMaterialColor.createMaterialColor(
                          const Color.fromARGB(200, 255, 45, 108)),
                      route: HomeScreen.routeName),
                ]))
          ],
        ),
      ),
    );
  }
}

final createMaterialColor = CreateMaterialColor();
