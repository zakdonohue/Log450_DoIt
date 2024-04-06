import 'package:flutter/material.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/ui/reusableWidgets/customtextfield.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:log450_doit/ui/reusableWidgets/buttonIcon.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
        return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white), // Set hint text color
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Set border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // Set border color when focused
          ),
        ),
      ),
    );
  }
}

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
    backgroundColor: Colors.white,
    body: Padding(
      padding: const EdgeInsets.only(top: 140.0),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 0, 150, 224),
                Color(0xFF0AAAF8),
              ],
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 42.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Informations personnelles",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          hintText: "Prenom",
                          controller: controllerSurname,
                        ),
                        CustomTextField(
                          hintText: "Nom de famille",
                          controller: controllerLastName,
                        ),
                        CustomTextField(
                          hintText: "Ville",
                          controller: controllerCity,
                        ),
                        CustomTextField(
                          hintText: "Province",
                          controller: controllerProvince,
                        ),
                        CustomTextField(
                          hintText: "Pays",
                          controller: controllerCountry,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Informations de connexion",
                          style: TextStyle(
                            color: Color.fromARGB(199, 2, 14, 43),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          hintText: "Email",
                          controller: controllerEmail,
                        ),
                        CustomTextField(
                          hintText: "Nom d'identifiant",
                          controller: controllerUsername,
                        ),
                        CustomTextField(
                          hintText: "Mot de passe",
                          controller: controllerPassword,
                        ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 40.0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _CreateUser(
                                  controllerUsername,
                                  controllerPassword,
                                  controllerEmail,
                                  controllerSurname,
                                  controllerLastName,
                                  controllerCity,
                                  controllerProvince,
                                  controllerCountry,
                                );
                                Navigator.pushNamed(context, CoreApp.routeName);
                              },
                              label: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Creer le compte",
                                  style: TextStyle(
                                    color: Color.fromARGB(200, 255, 45, 108),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              icon: Image.asset(
                                'assets/loginicon.png',
                                width: 24.0,
                                height: 24.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
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
}

InputDecoration customInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    filled: true,
    fillColor: Colors.transparent,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(8.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(8.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
  );
}

final createMaterialColor = CreateMaterialColor();
