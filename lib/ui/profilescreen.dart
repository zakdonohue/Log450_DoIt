import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:log450_doit/ui/reusableWidgets/camera.dart';
import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userId = SharedPreferences.shared.userId;
  List<dynamic> tasks = [];

  @override
  void initState() {
    super.initState();
    _fetchUserTasks();
  }

  Future<void> _fetchUserTasks() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/users/$userId/tasks'));
      if (response.statusCode == 200) {
        setState(() {
          tasks = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    int incompleteTaskCount = tasks.where((task) => task['isDone'] == false).length;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          const Text(
            'TÂCHES',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 16),
          Text(
            'Vous avez $incompleteTaskCount taches à completer',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          tasks.isEmpty
              ? const Center(
                  child: Text("Vous n'avez aucunes taches."),
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
                                colors: [
                                  task['isDone'] == true ? Color.fromARGB(255, 102, 241, 126) : const Color.fromARGB(255, 65, 180, 238),
                                  task['isDone'] == true ? Color.fromARGB(255, 14, 204, 46) : const Color.fromARGB(255, 54, 155, 206),
                                ],
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
                              trailing: IconButton(
                                icon: Icon(
                                  task['isDone'] == true ? Icons.check : Icons.camera_alt, 
                                  color: Colors.white
                                  ),
                                onPressed: () async {
                                  print(task.toString());
                                  await openCameraAndSavePhoto(SharedPreferences.shared.userId, task["_id"]);
                                  await _fetchUserTasks();
                                },
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
