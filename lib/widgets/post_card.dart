import 'package:cut_info/models/post.dart';
import 'package:cut_info/pages/post_view_page.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  const PostCard(
      {Key? key,
      required this.postTitle,
      required this.postText,
      required this.fullPostText,
      required this.containsImage,
      required this.dateTime,
      required this.objectId})
      : super(key: key);

  final String postTitle;
  final String postText;
  final String fullPostText;
  final bool containsImage;
  final DateTime dateTime;
  final String objectId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostView(
                objectID: objectId,
              ),
              settings: RouteSettings(
                arguments: Posts(postTitle, fullPostText, getUserYear(), false,
                    dateTime, objectId),
              ),
            ),
          ); //End navigator
        }, //End onTap
        child: Card(
          child: ListTile(
            tileColor: Colors.lightBlue.shade400,
            title: Text(
              "$postTitle",
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70),
                        borderRadius: BorderRadius.all(Radius.circular(7))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 15, right: 15),
                      child: Text(
                        postText,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("$dateTime"),
                    ],
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  } //End Widget
}//End class Postcard
