import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/friendItem.dart';
import 'package:log450_doit/ui/reusableWidgets/searchBar.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class ManageFriendsScreen extends StatelessWidget {
  const ManageFriendsScreen({super.key});

  static const routeName = '/managefriends';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: createMaterialColor
            .createMaterialColor(const Color.fromARGB(198, 163, 33, 104)),
        body: Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: Column(children: [
            const CustomSearchBar(),

            // TODO Populate with bd suggestion
            ListView(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              children: const <Widget>[
                FriendItem(
                    imagePath: "assets/female1.png",
                    name: "Claire Delalune",
                    buttonText: "Ajouter"),
                FriendItem(
                    imagePath: "assets/male1.png",
                    name: "Frodon Lano",
                    buttonText: "Ajouter"),
                FriendItem(
                    imagePath: "assets/male2.png",
                    name: "Bilal",
                    buttonText: "HELL NO"),
                FriendItem(
                    imagePath: "assets/female2.png",
                    name: "Lepetitbum d'acote",
                    buttonText: "Supprimer")
              ],
            )
          ]),
        ));
  }
}

final createMaterialColor = CreateMaterialColor();
