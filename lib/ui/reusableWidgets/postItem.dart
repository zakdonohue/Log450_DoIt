import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String imagePath;
  final String nameOfPostUser;
  final String nameOfTask;
  const PostItem(
      {super.key,
      required this.imagePath,
      required this.nameOfPostUser,
      required this.nameOfTask});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(children: [
        Image.asset(imagePath),
        Row(
          children: [
            const Icon(Icons.heart_broken),
            Column(children: [Text(nameOfPostUser), Text(nameOfTask)])
          ],
        )
      ]),
    ));
  }
}
