import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:log450_doit/homescreen.dart';
import 'package:log450_doit/ui/corenav.dart';
import 'package:log450_doit/ui/createaccountscreen.dart';
import 'package:log450_doit/ui/utils/MaterialColor.dart';
import 'package:http/http.dart' as http;
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Transform.scale(
                        scale: 0.8,
                        child: Image.asset('assets/Logo.png'),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 70.0),
                      child: Column(children: []),
                    ),
                    Expanded(
                      child: Container(
                        width: double.maxFinite,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF0AAAF8),
                              Color(0xFF85D5FC),
                            ],
                          ),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(70.0),
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.black.withOpacity(0.8),
                          //     spreadRadius: 10,
                          //     blurRadius: 20,
                          //     offset: const Offset(0, 12),
                          //   ),
                          // ],
                        ),
                        child: Column(
                          children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 32.0,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: const Text(
                                "Connexion",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 32.0,
                          ),
                          child: TextField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: "Enter your username",
                              labelText: "Username",
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0), 
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0), 
                                borderSide: const BorderSide(color: Colors.white), 
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: Colors.white), 
                              ),
                            ),
                            style: const TextStyle(color: Colors.white), 
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 32.0,
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              labelText: "Password",
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: Colors.white), 
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0), 
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 100.0,
                        right: 50.0,
                        left: 50.0,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 300,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                _authUser(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                              },
                              label: const Text(
                                "Se Connecter",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0AAAF8),
                                  fontSize: 21.0,
                                ),
                              ),
                              icon: const Icon(Icons.login, color:Color(0xFF0AAAF8)),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                elevation: 5, // Add elevation (drop shadow) to the button
                                shadowColor: Colors.black.withOpacity(0.8), // Shadow color
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                CreateAccountScreen.routeName,
                              );
                            },
                            child: const Text(
                                "Créer un compte",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authUser(String username, String password) async {
    const String apiUrl = "http://10.0.2.2:3000/users/auth";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "password_hash": password,
        }),
      );

         if (response.statusCode >= 200 && response.statusCode <= 299) {
            final responseBody = jsonDecode(response.body);
            final userId = responseBody['userId'];
            SharedPreferences.shared.userId = userId;
            Navigator.pushNamed(context, CoreApp.routeName);

            print("User authenticated successfully. UserId: $userId");
          } else if (response.statusCode == 401) {
            print("Invalid credentials. Please check your username and password.");

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("L'identifiant ou le mot de passe sont invalides."),
                duration: Duration(seconds: 3),
              ),
            );

          } else {
            print("Failed to authenticate. Status code: ${response.statusCode}");
          }
    } catch (e) {
      print("Error authenticating user: $e");
    }
  }
}

final createMaterialColor = CreateMaterialColor();