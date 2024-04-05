import 'package:flutter/material.dart';
import 'package:log450_doit/ui/createaccountscreen.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/ui/reusableWidgets/buttonIcon.dart';
import 'package:log450_doit/ui/reusableWidgets/customtextfield.dart';
import 'package:log450_doit/ui/utils/MaterialColor.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Image.asset('assets/doit.webp'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 70.0),
              child: Column(children: []),
            ),
            Expanded(
                child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: createMaterialColor.createMaterialColor(
                            const Color.fromARGB(200, 97, 115, 160)),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20.0))),
                    child: Column(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Column(children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 32.0,
                                ),
                                child: CustomTextField(
                                    hintText: "Entrez le nom d'identifiant")),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 32.0,
                                ),
                                child: CustomTextField(
                                    hintText: "Entrez le mot de passe"))
                          ])),
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 100.0, right: 50.0, left: 50.0),
                          child: Column(children: [
                            ButtonIcon(
                                buttonText: "Creer un compte",
                                icon: 'assets/createaccounticon.png',
                                textColor: createMaterialColor
                                    .createMaterialColor(const Color.fromARGB(
                                        200, 255, 45, 108)),
                                route: CreateAccountScreen.routeName),
                            ButtonIcon(
                                buttonText: "Se connecter",
                                icon: 'assets/loginicon.png',
                                textColor: createMaterialColor
                                    .createMaterialColor(const Color.fromARGB(
                                        200, 255, 45, 108)),
                                route: CoreApp.routeName),
                          ]))
                    ]))),
          ],
        ),
      ),
    );
  }
}

final createMaterialColor = CreateMaterialColor();
