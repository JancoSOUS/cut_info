import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/comment.dart';
import 'package:cut_info/models/post.dart';
import 'package:cut_info/routes/routes.dart';
import 'package:cut_info/services/helper_comment.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/comment_card.dart';
import 'package:cut_info/widgets/create_comment_popup.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key, this.objectID}) : super(key: key);

  final String? objectID;

  @override
  State<PostView> createState() => _PostViewState();
} //End class

class _PostViewState extends State<PostView> {
  late TextEditingController postCommentController;

  List<Comment> comments = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    postCommentController = TextEditingController();

    recieveComments(widget.objectID).then((value) {
      setState(() {
        comments = value;
      });
    });
  } //End initState()

  @override
  void dispose() {
    postCommentController.dispose();
    super.dispose();
  } //End dispose()

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Posts;

    Future<void> deleteDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text('Are you sure you want to delete this post ?'),
            actions: [
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ), //End cancel button
              TextButton(
                child: Text(
                  'Delete',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ), //End delete button
                onPressed: () {
                  Navigator.of(context).pop();
                  Map data = {
                    'title': post.title,
                    'content': post.content,
                    'year': post.year,
                    'hasImage': post.hasImage,
                    'created': post.created,
                    'objectId': post.objectId
                  }; //End map

                  Backendless.data.of("Everyone").remove(entity: data);

                  Backendless.data.of(getUserCourse()).remove(entity: data);

                  Navigator.popAndPushNamed(context, RouteManager.mainPage);
                }, //End onPressed: ()
              ),
            ],
          ); //end AlertDialog for post delete
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade700,
          title: Text('Post'),
          actions: <Widget>[
            Visibility(
              visible: getIsAdmin(),
              child: IconButton(
                onPressed: () {
                  deleteDialog();
                },
                icon: Icon(Icons.delete),
                color: Colors.red,
                splashColor: Colors.purple,
                splashRadius: 50,
                tooltip: 'Delete Posts',
              ), //End delete button
            ),
            IconButton(
              icon: const Icon(Icons.comment),
              tooltip: 'Make a comment',
              onPressed: () async {
                await showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CommentPopup(
                      commentContentController: postCommentController,
                      context: context,
                      postID: post.objectId,
                    ); // end return
                  },
                );

                recieveComments(widget.objectID).then((value) {
                  setState(() {
                    comments = value;
                  }); //End recieveComments()
                });
              },
            ), //End comment button
          ],
        ),
        body: Stack(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue.shade700, Colors.lightBlue.shade50],
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          border: Border.all(
                                              color: Colors.black45,
                                              width: 1.5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 20,
                                                left: 5,
                                                right: 5),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6,
                                                    bottom: 6,
                                                    left: 25,
                                                    right: 25),
                                                child: Expanded(
                                                  child: Text(
                                                    post.title,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ), //End post title
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(post.content,
                                                style: TextStyle(
                                                    fontSize:
                                                        16)), //End post content
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(post.created
                                                    .toString()), //End post date Created
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return CommentCard(
                                userName: comments[index].userName,
                                dateAndTime: comments[index].created,
                                commentText: comments[index].comment);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  } //End Widget
}//End class
