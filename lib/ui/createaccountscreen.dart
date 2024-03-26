import 'package:flutter/material.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/ui/reusableWidgets/customtextfield.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:log450_doit/ui/reusableWidgets/buttonIcon.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  static const routeName = '/createaccount';
//13234B
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(200, 97, 115, 160)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 42.0),
                  child: Text(
                    "Rempli les informations afin de creer ton compte",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Informations personnelles",
                          style: TextStyle(
                              color: createMaterialColor.createMaterialColor(
                                  const Color.fromARGB(199, 2, 14, 43)),
                              fontWeight: FontWeight.bold)),
                      const CustomTextField(hintText: "Prenom"),
                      const CustomTextField(hintText: "Nom de famille"),
                      const CustomTextField(hintText: "Ville"),
                      const CustomTextField(hintText: "Province"),
                      const CustomTextField(hintText: "Pays"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Informations de connexion",
                          style: TextStyle(
                              color: createMaterialColor.createMaterialColor(
                                  const Color.fromARGB(199, 2, 14, 43)),
                              fontWeight: FontWeight.bold)),
                      const CustomTextField(hintText: "Nom d'identifiant"),
                      const CustomTextField(hintText: "Mot de passe"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ButtonIcon(
                      buttonText: "Creer le compte",
                      icon: 'assets/loginicon.png',
                      textColor: createMaterialColor.createMaterialColor(
                          const Color.fromARGB(200, 255, 45, 108)),
                      route: CoreApp.routeName),
                )
              ]),
        ));
  }
}

final createMaterialColor = CreateMaterialColor();
