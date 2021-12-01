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
    required this.context,
  }) : super(key: key);

  final TextEditingController postTitleController;
  final TextEditingController postContentController;

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    /////////////alertDialog//////////
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text('Create a new Post'),
      content: Column(
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: postTitleController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter Post Title.'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: postContentController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Post content.'),
              ),
            ),
          ),
          DropDownWidget()
        ],
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
            showSnackBar(context, "Creating Post");
            Navigator.of(context).pop();
            submitPost(postTitleController, postContentController);
            showSnackBar(context, "Post created");
          },
        ),
      ],
    );
    return (alertDialog);
  }
}
