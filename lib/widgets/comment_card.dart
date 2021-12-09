import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    Key? key,
    required this.userName,
    required this.dateAndTime,
    required this.commentText,
  }) : super(key: key);

  final userName;
  final dateAndTime;
  final commentText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black45),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        userName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 15, right: 15),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 30, right: 30),
                              child: Text(commentText,
                                  style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight
                                              .w500))), //end comment text
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 10, right: 10),
                              child: Text(
                                dateAndTime.toString(),
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.w600),
                              ), // End dateAndTime
                            )
                          ])),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  } //End Widget
} //End class
