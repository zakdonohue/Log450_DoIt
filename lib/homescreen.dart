import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/postItem.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(197, 167, 17, 17)),
        body: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: SizedBox.expand(
                child: Center(
                    child:
                        // TODO Populate with actual data from BD
                        ListView(
                            padding: const EdgeInsets.all(8),
                            children: const <Widget>[
                  PostItem(
                      imagePath: "assets/partyimage.jpg",
                      nameOfPostUser: "le boy SEGLAAAAA",
                      nameOfTask: "cest quand mm nice Flutter fr"),
                  PostItem(
                      imagePath: "assets/amusementpark.jpg",
                      nameOfPostUser: "BILAL",
                      nameOfTask:
                          "moi qui m'en sacre des corrections de mes eleves"),
                  PostItem(
                      imagePath: "assets/meeting.jpg",
                      nameOfPostUser: "Un finissant de l'ETS",
                      nameOfTask: "ma tronche a chaque matin"),
                  PostItem(
                      imagePath: "assets/paddleboard.jpg",
                      nameOfPostUser: "la fomme du dep",
                      nameOfTask: "fa bo fa chaud a 7h00 AM"),
                ])))));
  }
}

final createMaterialColor = CreateMaterialColor();
