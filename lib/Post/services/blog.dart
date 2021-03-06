import 'package:flutter/material.dart';
import 'package:blogpost/utils/show_snack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogService {
  CollectionReference blogCollection =
      FirebaseFirestore.instance.collection('blogs');

  Stream<QuerySnapshot> fetchBlogs(String filter) {
    return filter == ''
        ? blogCollection.orderBy("createdAt", descending: true).snapshots()
        : blogCollection.where("category", isEqualTo: filter).snapshots();
  }

  Stream<DocumentSnapshot> fetchBlog(String id) {
    return blogCollection.doc(id).snapshots();
  }

  Future<void> createBlog(
      {required BuildContext context,
      required Map<String, dynamic> data}) async {
    try {
      await blogCollection.add(data);
    } on FirebaseException catch (error) {
      showSnack(error.message, context);
    }
  }

  Future<void> updateBlog(
      {required BuildContext context,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      blogCollection.doc(docId).update(data);
    } on FirebaseException catch (error) {
      showSnack(error.message, context);
    }
  }

  Future<void> deleteBlog(
      {required String docId, required BuildContext context}) async {
    try {
      await blogCollection.doc(docId).delete();
    } on FirebaseException catch (error) {
      showSnack(error.message, context);
    }
  }
}
