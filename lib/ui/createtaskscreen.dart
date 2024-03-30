import 'package:flutter/material.dart';
import 'package:log450_doit/ui/utils/materialColor.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget {
  static String routeName = '/createTaskScreen';
    @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();


  static const routeName = '/createtask';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:Text('Create \nNew Task', 
          style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      centerTitle: true,
        elevation: 0, // Removes shadow for a flat design
        toolbarHeight: 150.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Container(
          decoration: BoxDecoration(
          color: Colors.white, // Assuming you have defined this properly
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          ),
          child: Column(
          children: <Widget>[
            // Task Name Input
            Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: 
            TextField(
              decoration: InputDecoration(
                labelText: '       Enter your task.',
                labelStyle: TextStyle(
                  fontSize: 18.0,
                  
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            ),
             SizedBox(height: 30),
            // Scrollable Dates
            Container(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 30,
                itemBuilder: (context, index) {
                  DateTime date = DateTime.now().add(Duration(days: index));
                  bool isToday = date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isToday) // Only add the dot if it's today's date
              Container(
                height: 6.0,
                width: 6.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                margin: EdgeInsets.only(bottom: 4.0), // Space between dot and text
              ),
            if(!isToday)
              Container(
                height: 6.0,
                width: 6.0,
                margin: EdgeInsets.only(bottom: 4.0),
              ),
            
            Text(
              DateFormat('dd MMM').format(date),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30.0), 
                      color: const Color.fromARGB(255, 214, 213, 213),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: 
        InkWell(
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null && picked != selectedTime)
                  setState(() {
                    selectedTime = picked;
                  });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text('Select Time: ${selectedTime.format(context)}'),
                alignment: Alignment.center,
              ),
            ),
            ),
            SizedBox(
              height: 20,
            ),
            // Search bar
            Divider(
              color: Colors.grey, // Color of the divider
              thickness: 1, // Thickness of the divider line
              indent: 30,
              endIndent: 30,
            ),
            Padding(
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintText: 'Search hashtag',
                hintStyle: TextStyle(
                  fontSize: 18.0,
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 30),
            // Time Input
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Save task logic
        },
        icon: Icon(Icons.save, color: Colors.white, size: 30,),
        label: Text('Save', style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  }

final createMaterialColor = CreateMaterialColor();
