import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:log450_doit/ui/utils/sharedPreferences.dart';

class CreateTaskScreen extends StatefulWidget {
  static String routeName = '/createTaskScreen';

  const CreateTaskScreen({super.key});
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  DateTime selectedDate = DateTime.now().add(const Duration(days: -1));
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _taskController = TextEditingController();
  int selectedIndex = 0;
  bool _isTaskEmpty = false;
  bool _taskAddedSuccessfully = false;

  Future<void> _addTask(String userId) async {
    final String apiUrl = "http://10.0.2.2:3000/users/$userId/tasks";
    DateTime dueDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    ).toUtc();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": _taskController.text,
          "due_date": dueDate.toIso8601String(),
          "isDone": false,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _taskAddedSuccessfully = true;
          _taskController.clear();
          selectedDate = DateTime.now().add(const Duration(days: -1));
          selectedTime = TimeOfDay.now();
          selectedIndex = 0;
        });

        // Hide success message after a few seconds
        Future.delayed(Duration(seconds: 5), () {
          setState(() {
            _taskAddedSuccessfully = false;
          });
        });
      } else {
        print("Failed to add task: ${response.body}");
      }
    } catch (e) {
      print("Error adding task: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Créer \n une tache',
            style: TextStyle(
                color: Color(0xFF0AAAF8),
                fontSize: 40,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 200.0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0AAAF8),
                        Color(0xFF85D5FC),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: TextField(
                          controller: _taskController,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Entrer une tache.',
                            labelStyle: const TextStyle(
                                fontSize: 18.0, color: Colors.white),
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorText:
                                _isTaskEmpty ? 'Task cannot be empty.' : null,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 50),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                        indent: 30,
                        endIndent: 30,
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 30,
                          itemBuilder: (context, index) {
                            DateTime date =
                                DateTime.now().add(Duration(days: index));
                            bool isSelected = index == selectedIndex;
                            bool isToday = date.day == DateTime.now().day &&
                                date.month == DateTime.now().month &&
                                date.year == DateTime.now().year;
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedDate =
                                      DateTime.now().add(Duration(days: index));
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: isSelected
                                      ? Colors.white
                                      : Color.fromARGB(0, 214, 213, 213),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    if (isToday)
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 4.0),
                                      ),
                                    if (!isToday)
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        margin:
                                            const EdgeInsets.only(bottom: 4.0),
                                      ),
                                    Text(
                                      DateFormat('dd MMM').format(date),
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: InkWell(
                          onTap: () async {
                            TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );
                            if (picked != null && picked != selectedTime) {
                              setState(() {
                                selectedTime = picked;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Select Time: ${selectedTime.format(context)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (!_taskAddedSuccessfully)
                      const SizedBox(height: 60),
                      if (_taskAddedSuccessfully)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 30.0),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.green, width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Tâche créée avec succès!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      FloatingActionButton.extended(
                        heroTag: "uniqueTagForCreateTask",
                        onPressed: () {
                          if (_taskController.text.isEmpty) {
                            setState(() {
                              _isTaskEmpty = true;
                            });
                            return;
                          } else {
                            setState(() {
                              _isTaskEmpty = false;
                              _addTask(SharedPreferences.shared.userId);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.save,
                          color: Color(0xFF0AAAF8),
                          size: 30,
                        ),
                        label: const Text(
                          'Enregistrer',
                          style:
                              TextStyle(color: Color(0xFF0AAAF8), fontSize: 25),
                        ),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

final createMaterialColor = CreateMaterialColor();
