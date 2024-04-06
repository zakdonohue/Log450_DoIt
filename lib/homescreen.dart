import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:log450_doit/ui/reusableWidgets/postItem.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    String currentUserId = '';
    _getTasksOfFriends(currentUserId);
  }

  Future<void> _getTasksOfFriends(String userId) async {
    final String friendsUrl = "http://10.0.2.2:3000/users/$userId/friends";
    List<dynamic> friends = [];

    try {
      final responseFriends = await http.get(Uri.parse(friendsUrl), headers: {"Content-Type": "application/json"});
      if (responseFriends.statusCode == 200) {
        friends = jsonDecode(responseFriends.body);

        for (var friend in friends) {
          String friendId = friend['friend_user_id'];
          print('Friend Id $friendId: $friendId');
          final String tasksUrl = "http://10.0.2.2:3000/users/$friendId/tasks";

          // Fetch tasks for each friend
          final responseTasks = await http.get(Uri.parse(tasksUrl), headers: {"Content-Type": "application/json"});
          if (responseTasks.statusCode == 200) {
            List<dynamic> tasks = jsonDecode(responseTasks.body);
            print('Tasks for friend $friendId: $tasks');
          } else {
            print("Failed to get tasks for friend $friendId: ${responseTasks.body}");
          }
        }
      } else {
        print("Failed to get friends: ${responseFriends.body}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        body:SizedBox.expand(
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
                ]))));
  }
}

final createMaterialColor = CreateMaterialColor();
