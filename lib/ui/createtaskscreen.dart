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
        print("Task added successfully");
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
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Create \nNew Task',
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 150.0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    labelText: '       Enter your task.',
                    labelStyle: const TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    errorText: _isTaskEmpty ? 'Task cannot be empty.' : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Scrollable Dates
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    DateTime date = DateTime.now().add(Duration(days: index));
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
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30.0),
                          color: isSelected
                              ? Colors.grey.shade600
                              : const Color.fromARGB(255, 214, 213, 213),
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
                                margin: const EdgeInsets.only(bottom: 4.0),
                              ),
                            if (!isToday)
                              Container(
                                height: 6.0,
                                width: 6.0,
                                margin: const EdgeInsets.only(bottom: 4.0),
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
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
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
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    alignment: Alignment.center,
                    child: Text('Select Time: ${selectedTime.format(context)}'),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Search bar
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 30,
                endIndent: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                child: TextField(
                  // controller: _searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Search hashtag',
                    hintStyle: const TextStyle(
                      fontSize: 18.0,
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onSubmitted: (value) {
                    // searchHashtag(value);
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Hashtags
              Wrap(
                spacing: 8.0,
                children: List<Widget>.generate(
                  5,
                  (int index) {
                    return Chip(
                      label: Text('#hashtag${index + 1}'),
                      backgroundColor: const Color.fromARGB(255, 85, 187, 155),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_taskController.text.isEmpty) {
            setState(() {
              _isTaskEmpty = true;
            });
            return;
          } else {
            setState(() {
              _isTaskEmpty = false; // Reset the visual cue state
              _addTask(SharedPreferences.shared.userId);
            });
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
          size: 30,
        ),
        label: const Text('Save',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.deepPurple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

final createMaterialColor = CreateMaterialColor();
