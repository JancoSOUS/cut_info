import 'package:cut_info/services/helper_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'snackbar.dart';

class CommentPopup extends StatelessWidget {
  const CommentPopup({
    Key? key,
    required this.commentContentController,
    required this.postID,
    required this.context,
  }) : super(key: key);

  final TextEditingController commentContentController;

  final BuildContext context;
  final String postID;

  @override
  Widget build(BuildContext context) {
    /////////////alertDialog//////////

    AlertDialog commentDialog = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Create a new Comment'),
      content: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                controller: commentContentController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter comment content.'),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () {
            commentContentController.text = '';
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Save',
            style: TextStyle(color: Colors.lightBlue.shade400, fontSize: 18),
          ),
          onPressed: () {
            if (commentContentController.text == '') {
              showSnackBar(context, 'Please type your comment!');
            } else {
              Navigator.of(context).pop();
              submitComment(commentContentController.text, postID);
              commentContentController.clear();
            }
          },
        ),
      ],
    );
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: Center(child: SingleChildScrollView(child: commentDialog)));
  }
}
