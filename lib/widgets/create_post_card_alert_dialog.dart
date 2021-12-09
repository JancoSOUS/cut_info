import 'package:cut_info/services/helper_post.dart';
import 'package:cut_info/widgets/create_post_dropdown.dart';
import 'package:cut_info/widgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePostCard extends StatelessWidget {
  const CreatePostCard({
    Key? key,
    required this.postTitleController,
    required this.postContentController,
  }) : super(key: key);

  final TextEditingController postTitleController;
  final TextEditingController postContentController;

  @override
  Widget build(BuildContext context) {
    /////////////alertDialog//////////
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Create a new Post'),
      content: Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          CreatePostDropdown(),
          TextField(
            maxLength: 40,
            keyboardType: TextInputType.text,
            controller: postTitleController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter Post Title.'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 40,
                controller: postContentController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Post content.'),
              ),
            ),
          )
        ], //End Create Post drop down
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          onPressed: () {
            postTitleController.text = '';
            postContentController.text = '';
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Save',
            style: TextStyle(color: Colors.lightBlue.shade400, fontSize: 18),
          ),
          onPressed: () {
            if (postTitleController.text == '') {
              showSnackBar(context, 'Please enter a post title!');
            } else if (postContentController.text == '') {
              showSnackBar(context, 'Please type the post content!');
            } else {
              Navigator.of(context).pop();
              showSnackBar(context, "Creating Post");
              submitPost(postTitleController, postContentController);
              showSnackBar(context, "Post created");
            }
          },
        ),
      ], //End save & cancel buttons
    );
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: SingleChildScrollView(child: alertDialog)); // end return
  } //End Widget
}//End class
