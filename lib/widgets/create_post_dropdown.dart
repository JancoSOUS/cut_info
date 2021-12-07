import 'package:flutter/material.dart';

String _newPostCourse = 'Everyone';
String _newPostYear = 'Everyone';

String getNewPostCourse() {
  return _newPostCourse;
}

String getNewPostYear() {
  return _newPostYear;
}

class CreatePostDropdown extends StatefulWidget {
  const CreatePostDropdown({Key? key}) : super(key: key);

  @override
  State<CreatePostDropdown> createState() => _DropDownStatefulWidgetState();
}

/// This is the private State class that goes with CreatePostDropdown.
class _DropDownStatefulWidgetState extends State<CreatePostDropdown> {
  List<String> courses = <String>[
    'Everyone',
    'IT',
    'Marketing',
    'Somatology',
    'Mec Engineering',
    'Ele Engineering',
    'Hospitality'
  ];

  List<String> years = <String>[
    'Everyone',
    '1',
    '2',
    '3',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
            },
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
        Container(
          width: 120,
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
            },
            items: years.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
