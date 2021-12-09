import 'package:cut_info/Data/course_list.dart';
import 'package:flutter/material.dart';

String _newPostCourse = 'Everyone';
String _newPostYear = 'Everyone';

String getNewPostCourse() {
  return _newPostCourse;
} //End getNewPostCourse()

String getNewPostYear() {
  return _newPostYear;
} //End getNewPostYear()

class CreatePostDropdown extends StatefulWidget {
  const CreatePostDropdown({Key? key}) : super(key: key);

  @override
  State<CreatePostDropdown> createState() => _DropDownStatefulWidgetState();
} //End class

/// This is the private State class that goes with CreatePostDropdown.
class _DropDownStatefulWidgetState extends State<CreatePostDropdown> {
  List<String> courses = ["Everyone"] + getCourses();
  List<String> years = ['Everyone'] + getYears();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Select Course"), Text("Select Year")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            // Drop down 1 start
            //
            Container(
              width: 120,
              child: DropdownButton<String>(
                value: _newPostCourse,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 16,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 3,
                  color: Colors.lightBlue.shade400,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _newPostCourse = newValue!;
                  });
                }, //End onChanged
                items: courses.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
            ),
/* ...................................
................   drop down 1 end 
...................................... */
            //
            //dropdown 2 start
            //
            Container(
              width: 80,
              child: DropdownButton<String>(
                value: _newPostYear,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black,
                ),
                iconSize: 16,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 3,
                  color: Colors.lightBlue.shade400,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    _newPostYear = newValue!;
                  });
                }, //End onChanged
                items: years.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            //
            //dropdown 2 End#
            //
          ],
        ),
      ],
    );
  } //End Widget
} //End class
