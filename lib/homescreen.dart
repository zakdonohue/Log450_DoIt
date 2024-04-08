import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/postItem.dart';
import 'package:log450_doit/ui/utils/localnotifservice.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = TextEditingController();
  List<Map<String, String>> posts = [];

  @override
  void initState() {
    super.initState();
    _getTasksOfFriends(SharedPreferences.shared.userId);
  }

  Future<void> _getTasksOfFriends(String userId) async {
    final String userURL = "http://10.0.2.2:3000/users/$userId";

    try {
      final responseUser = await http.get(Uri.parse(userURL),
          headers: {"Content-Type": "application/json"});
      if (responseUser.statusCode == 200) {
        Map<String, dynamic> userData = jsonDecode(responseUser.body);
        List<dynamic> friendIds = userData['friend_ids'];

        for (var friendId in friendIds) {
          final String friendsUrl = "http://10.0.2.2:3000/users/$friendId";
          final responseFriends = await http.get(Uri.parse(friendsUrl),
              headers: {"Content-Type": "application/json"});

          if (responseFriends.statusCode == 200) {
            Map<String, dynamic> friendData = jsonDecode(responseFriends.body);
            String friendName = "${friendData['username']}";

            final String tasksUrl =
                "http://10.0.2.2:3000/users/$friendId/tasks";
            final responseTasks = await http.get(Uri.parse(tasksUrl),
                headers: {"Content-Type": "application/json"});

                print(responseTasks.body);

            if (responseTasks.statusCode == 200) {
              List<dynamic> tasks = jsonDecode(responseTasks.body);

              for (var task in tasks) {
                String? imageBase64;
                if (task['isDone'] == true && task['image'] != null) {
                  List<int> imageData = List<int>.from(task['image']['data']);
                  imageBase64 = base64Encode(imageData);

                  Map<String, String> post = {
                    'image': imageBase64,
                    'nameOfPostUser': friendName,
                    'nameOfTask': task['title'],
                  };

                  setState(() {
                    posts.add(post);
                  });
                }
              }
            } else {
              print(
                  "Failed to get tasks for friend $friendId: ${responseTasks.body}");
            }
          } else {
            print("Failed to get friends: ${responseFriends.body}");
          }
        }
      } else {
        print("Failed to get user data: ${responseUser.body}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    if (posts.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Vous n'avez aucune actualité. \n Ajoutez plus d'amis!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index) {
              var post = posts[index];
              return PostItem(
                imageBase64: post['image']!,
                nameOfPostUser: post['nameOfPostUser']!,
                nameOfTask: post['nameOfTask']!,
              );
            },
          ),
        ),
      ),
    );
  }
}

final createMaterialColor = CreateMaterialColor();
