import 'dart:convert';

import 'package:flutter/material.dart';
import 'camera.dart';

class PostItem extends StatefulWidget {
  final String imageBase64;
  final String nameOfPostUser;
  final String nameOfTask;

  const PostItem({
    super.key,
    required this.imageBase64,
    required this.nameOfPostUser,
    required this.nameOfTask,
  });

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool _isLiked = false;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 5,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  widget.imageBase64.isNotEmpty
                      ? Image.memory(
                          base64Decode(widget.imageBase64),
                          width: double.infinity, // Adjusted to fill the width
                          height: 200, // Arbitrary height, adjust as needed
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.task,
                          size: 50), // Example fallback icon with size
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "@${widget.nameOfPostUser}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.nameOfTask,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _toggleLike();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
