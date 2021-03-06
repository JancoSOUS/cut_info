import 'dart:io';

import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:cut_info/models/post.dart';
import 'package:cut_info/services/user_service.dart';
import 'package:cut_info/widgets/app_progress_indicator.dart';
import 'package:cut_info/widgets/create_post_dropdown.dart';
import 'package:cut_info/widgets/snackbar.dart';
import 'package:flutter/material.dart';

Future<void> submitPost(TextEditingController postTitleController,
    TextEditingController postContentController) async {
  AppProgressIndicator(text: 'Creating Post');

  Posts newPost = new Posts(postTitleController.text,
      postContentController.text, getNewPostYear(), false, DateTime.now(), "");

  postTitleController.text = '';
  postContentController.text = '';

  Map data = {
    'title': newPost.title,
    'content': newPost.content,
    'year': newPost.year,
    'hasImage': newPost.hasImage,
    'created': newPost.created
  };

  await Backendless.data.of(getNewPostCourse()).save(data);
} // end submitPost()

Future<List<Posts>> recievePosts(context) async {
  sleep(Duration(microseconds: 200));
  List<Posts> posts = List.empty(growable: true);
  DataQueryBuilder queryBuilder = DataQueryBuilder()..pageSize = 100;

  await Backendless.data.of("Everyone").find(queryBuilder).then(
    (tablePosts) {
      tablePosts!.forEach((element) {
        if (element?["year"] == "Everyone" ||
            element?["year"] == getUserYear()) {
          Posts post = new Posts(
              element?["title"],
              element?["content"],
              element?["year"],
              element?["hasImage"],
              element?["created"],
              element?["objectId"]);
          posts.add(post);
        } // end if
      });
    },
  ).onError(
    (error, stackTrace) {
      showSnackBar(context, "Database Everyone is not found");
    },
  );

  await Backendless.data.of(getUserCourse()).find(queryBuilder).then(
    (tablePosts) {
      tablePosts!.forEach(
        (element) {
          if (element?["year"] == "Everyone" ||
              element?["year"] == getUserYear()) {
            Posts post = new Posts(
                element?["title"],
                element?["content"],
                element?["year"],
                element?["hasImage"],
                element?["created"],
                element?["objectId"]);
            posts.add(post);
          } // end if
        },
      );
    },
  ).onError(
    (error, stackTrace) {
      showSnackBar(context, "Database $getUserCourse() is not found");
    },
  );

  posts.sort((a, b) => b.created.compareTo(a.created));

  return posts;
}// end recievePosts()
