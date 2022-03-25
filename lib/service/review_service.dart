import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewService extends ChangeNotifier {
  final reviewCollection = FirebaseFirestore.instance.collection('review');
  final movieCollection = FirebaseFirestore.instance.collection('movie');

  Future<QuerySnapshot> read(String name) async {
    // 내 bucketList 가져오기

    return movieCollection.where('name', isEqualTo: name).get();
  }

  Future<QuerySnapshot> readMyReview(String uid) async {
    // 내 reviewList 가져오기

    return reviewCollection.where('uid', isEqualTo: uid).get();
  }

  void create(String uid, String content, String mid, String name) async {
    await reviewCollection.add({
      'uid': uid,
      'content': content,
      'likeList': [],
      'mid': mid,
      'name': name,
    });
    notifyListeners();
  }

  void update(String docId, String content) async {
    // bucket isDone 업데이트
  }

  void delete(String docId) async {
    await reviewCollection.doc(docId).delete();
  }
}
