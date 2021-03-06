import 'package:cut_info/Data/course_list.dart';
import 'package:flutter/material.dart';

String dropdownYear = '1';

String getDropdownYear() {
  return dropdownYear;
} //End getDropdownYear()

class RegisterYearDropDownWidget extends StatefulWidget {
  const RegisterYearDropDownWidget({Key? key}) : super(key: key);

  @override
  State<RegisterYearDropDownWidget> createState() =>
      _DropDownStatefulWidgetState();
} // end RegisterYearDropDownWidget class

/// This is the private State class that goes with RegisterYearDropDownWidget.
class _DropDownStatefulWidgetState extends State<RegisterYearDropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Select your year of study"),
        Container(
          width: 75,
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownYear,
            icon: const Icon(
              Icons.arrow_downward,
              color: Colors.black,
            ),
            iconSize: 16,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(height: 3, color: Colors.grey),
            onChanged: (String? newValue) {
              setState(
                () {
                  dropdownYear = newValue!;
                },
              );
            },
            items: getYears().map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  } //End Widget
}//End class
