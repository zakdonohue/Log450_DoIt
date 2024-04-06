import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class Task {
  final String id;
  final String? title;
  final bool? isDone;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? imageUrl;

  Task({
    required this.id,
    this.title,
    this.isDone,
    this.dueDate,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  // Factory constructor to create a Task from JSON data
  factory Task.fromJson(Map<String, dynamic> json) {
    // Convert the "data" array from the "image" field to a base64 string
    String? imageBase64;
    if (json['isDone'] == true && json['image'] != null) {
      List<int> imageData = List<int>.from(json['image']['data']);
      imageBase64 = base64Encode(imageData);
    }

    return Task(
      id: json['_id'],
      title: json['title'],
      isDone: json['isDone'],
      dueDate:
          json['due_date'] != null ? DateTime.tryParse(json['due_date']) : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      imageUrl: imageBase64,
    );
  }
}

class TaskUtils {
  static Future<List<Task>> fetchUserTasks(String userId) async {
    final String apiUrl = "http://10.0.2.2:3000/users/$userId/tasks";
    List<Task> tasks = [];

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> tasksJson = json.decode(response.body);
        tasks = tasksJson.map((taskJson) => Task.fromJson(taskJson)).toList();
      } else {
        print('Failed to load tasks. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load tasks. Exception: $e');
    }

    return tasks;
  }
}

class TasksListView extends StatelessWidget {
  final String userId;

  const TasksListView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: TaskUtils.fetchUserTasks(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Text('No tasks found.');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Task task = snapshot.data![index];
              return ListTile(
                title: Text(task.title ?? 'No title'),
                leading: task.imageUrl != null
                    ? Image.memory(base64Decode(task.imageUrl!), width: 50, height: 50, fit: BoxFit.cover)
                    : const Icon(Icons.task), // Display an icon if there's no image.
              );
            },
          );
        }
      },
    );
  }
}


Future<void> openCameraAndSavePhoto(String userId, String taskId) async {
  // Request camera permission
  var status = await Permission.camera.request();
  if (status != PermissionStatus.granted) {
    print('Camera permission not granted');
    return;
  }

  // Open camera to capture image
  final ImagePicker picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
  final String apiUrl = "http://10.0.2.2:3000/users/$userId/tasks/$taskId";

  if (pickedFile != null) {
    // Prepare for upload
    final uri = Uri.parse(apiUrl); // Endpoint URL
    final request = http.MultipartRequest('POST', uri)
      ..fields['isDone'] = 'true' // Set isDone to true
      ..files.add(await http.MultipartFile.fromPath(
        'image', // The field name for the image
        pickedFile.path,
      ));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print('Image and task status uploaded successfully');
      } else {
        print(response.statusCode);
        print('Failed to upload image and update task status');
      }
    } catch (e) {
      print('Error uploading image and updating task status: $e');
    }
  } else {
    print('No image selected.');
  }
}
