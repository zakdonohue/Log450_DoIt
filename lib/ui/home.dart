import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/buttonIcon.dart';
import 'package:log450_doit/ui/utils/MaterialColor.dart';

final createMaterialColor = CreateMaterialColor();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: createMaterialColor
          .createMaterialColor(Color.fromARGB(200, 97, 115, 160)),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Image.asset('assets/doit.webp'),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Entrez le nom d'identifiant"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Entrez le mot de passe"),
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {},
                label: Align(
                    alignment: Alignment.centerLeft, child: new Text("yo")),
                icon: Image.asset('assets/createaccounticon.png')),
            ElevatedButton.icon(
                onPressed: () {},
                label: Align(
                    alignment: Alignment.centerLeft, child: new Text("bla")),
                icon: Image.asset('assets/createaccounticon.png'))
          ],
        ),
      ),
    );
  }
}
