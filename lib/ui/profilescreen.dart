import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:log450_doit/ui/reusableWidgets/camera.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = '/profile';

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late String userId = SharedPreferences.shared.userId;
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchUserTasks();
  }

  Future<void> fetchUserTasks() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/users/$userId/tasks'));
      if (response.statusCode == 200) {
        setState(() {
          tasks = jsonDecode(response.body);
        });
        print("fetched UsersTasks.");
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final response = await http.delete(Uri.parse('http://10.0.2.2:3000/users/$userId/tasks/$taskId'));
      if (response.statusCode == 200) {
        setState(() {
          tasks.removeWhere((task) => task['_id'] == taskId);
        });
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (error) {
      print('Error deleting task: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    int incompleteTaskCount = tasks.where((task) => !task['isDone']).length;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          const Text(
            'TASKS',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 16),
          Text(
            'You have $incompleteTaskCount tasks to complete',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          tasks.isEmpty
              ? const Center(
                  child: Text("You don't have any tasks."),
                )
              : Expanded(
                  child: ListView(
                    children: tasks.map((task) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: task['isDone']
                                    ? [Color.fromARGB(255, 102, 241, 126), Color.fromARGB(255, 14, 204, 46)]
                                    : [Color.fromARGB(255, 65, 180, 238), Color.fromARGB(255, 54, 155, 206)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              title: Text(
                                task['title'].toString().toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      task['isDone'] ? Icons.check : Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: () async {
                                      print(task.toString());
                                      await openCameraAndSavePhoto(SharedPreferences.shared.userId, task['_id']);
                                      await fetchUserTasks();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Supprimer tache'),
                                            content: Text('Etes-vous certain de vouloir supprimer cette tache?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  deleteTask(task['_id']);
                                                },
                                                child: Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
        ],
      ),
    );
  }
}
