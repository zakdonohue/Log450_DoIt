import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class FriendItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String buttonText;

  const FriendItem(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(imagePath,
            width: 32.0, height: 32.0, fit: BoxFit.cover),
      ),
      const Spacer(),
      Text(name),
      const Spacer(),
      ElevatedButton(
          //TODO do action to include in friends,bd , etc.
          onPressed: () {},
          child: Align(
              alignment: Alignment.center,
              child: Text(
                buttonText,
                style: TextStyle(
                    color: createMaterialColor.createMaterialColor(
                        const Color.fromARGB(200, 255, 45, 108)),
                    fontWeight: FontWeight.bold),
              )))
    ]);
  }
}

final createMaterialColor = CreateMaterialColor();


//Fluttertoast.showToast(
              // msg: "This is a Toast message",
              // toastLength: Toast.LENGTH_SHORT,
              // gravity: ToastGravity.CENTER,
              // timeInSecForIosWeb: 1,
              // textColor: Colors.white,
              // fontSize: 16.0)