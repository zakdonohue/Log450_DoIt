import 'package:flutter/material.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/ui/reusableWidgets/customtextfield.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:log450_doit/ui/reusableWidgets/buttonIcon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = '/createaccount';

  const CreateAccountScreen({super.key});
  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  int selectedIndex = 0;

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSurname = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerProvince = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(200, 97, 115, 160)),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
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
                                  color:
                                      createMaterialColor.createMaterialColor(
                                          const Color.fromARGB(199, 2, 14, 43)),
                                  fontWeight: FontWeight.bold)),
                          CustomTextField(
                              hintText: "Prenom",
                              controller: controllerSurname),
                          CustomTextField(
                              hintText: "Nom de famille",
                              controller: controllerLastName),
                          CustomTextField(
                              hintText: "Ville", controller: controllerCity),
                          CustomTextField(
                              hintText: "Province",
                              controller: controllerProvince),
                          CustomTextField(
                              hintText: "Pays", controller: controllerCountry),
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
                                  color:
                                      createMaterialColor.createMaterialColor(
                                          const Color.fromARGB(199, 2, 14, 43)),
                                  fontWeight: FontWeight.bold)),
                          CustomTextField(
                              hintText: "Email", controller: controllerEmail),
                          CustomTextField(
                              hintText: "Nom d'identifiant",
                              controller: controllerUsername),
                          CustomTextField(
                              hintText: "Mot de passe",
                              controller: controllerPassword),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40.0),
                                child: ElevatedButton.icon(
                                    onPressed: () => {
                                          Navigator.pushNamed(
                                              context, CoreApp.routeName),
                                          setState(() {
                                            _CreateUser(
                                              controllerUsername =
                                                  controllerUsername,
                                              controllerPassword =
                                                  controllerPassword,
                                              controllerEmail = controllerEmail,
                                              controllerSurname =
                                                  controllerSurname,
                                              controllerLastName =
                                                  controllerLastName,
                                              controllerCity = controllerCity,
                                              controllerProvince =
                                                  controllerProvince,
                                              controllerCountry =
                                                  controllerCountry,
                                            );
                                          })
                                        },
                                    label: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Creer le compte",
                                          style: TextStyle(
                                              color: createMaterialColor
                                                  .createMaterialColor(
                                                      const Color.fromARGB(
                                                          200, 255, 45, 108)),
                                              fontWeight: FontWeight.bold),
                                        )),
                                    icon: Image.asset('assets/loginicon.png',
                                        width: 24.0, height: 24.0)),
                              )
                            ])))
                  ]),
            )));
  }
}

Future<void> _CreateUser(
    TextEditingController? controllerUsername,
    TextEditingController? controllerPassword,
    TextEditingController? controllerEmail,
    TextEditingController? controllerSurname,
    TextEditingController? controllerLastName,
    TextEditingController? controllerCity,
    TextEditingController? controllerProvince,
    TextEditingController? controllerCountry) async {
  const String apiUrl = "http://10.0.2.2:3000/users";

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": controllerUsername?.text,
        "email": controllerEmail?.text,
        "password_hash": controllerPassword?.text,
        "surname": controllerSurname?.text,
        "lastName": controllerLastName?.text,
        "city": controllerCity?.text,
        "province": controllerProvince?.text,
        "country": controllerCountry?.text,
        "settings": {
          "is_account_private": false,
          "notifications_enabled": false
        }
      }),
    );

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print("User created successfully");
    } else {
      print("Failed to create user: ${response.body}");
    }
  } catch (e) {
    print("Error create user: $e");
  }
}

final createMaterialColor = CreateMaterialColor();
