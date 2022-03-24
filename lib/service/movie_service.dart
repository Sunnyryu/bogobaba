import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MovieService extends ChangeNotifier {
  final movieCollection = FirebaseFirestore.instance.collection('movie');
  final reviewCollection = FirebaseFirestore.instance.collection('review');

  Future<QuerySnapshot> read(String name) async {
    return movieCollection
        .orderBy('name')
        .startAt([name]).endAt([name + '\uf8ff']).get();
  }

  Future<QuerySnapshot> readReview(String mid) async {
    return reviewCollection.where('mid', isEqualTo: mid).get();
  }

  void create(String name, String genre, String description, String category,
      String imgLink, String mid, String originalLink, String year) async {
    // bucket 만들기
    await movieCollection.add({
      'mid': mid, // 영화 식별자
      'category': category, // 큰 카테고리
      'name': name, // 영화 이름
      'year': year, // 년도
      'genre': genre, // 장르
      'imgLink': imgLink, // 이미지링크
      'originalLink': originalLink, // 연결링크
      'description': description, // 설명
    });
    notifyListeners(); // 화면 갱신
  }

  void updateAddLike(String docId, dynamic likeList) async {
    // bucket isDone 업데이트
    await reviewCollection.doc(docId).update({'likeList': likeList});
    notifyListeners(); // 화면 갱신
  }

  // void updateDeleteLike(String docId, bool likeList) async {
  //   // bucket isDone 업데이트
  //   await reviewCollection.doc(docId).update({'likeList': likeList});
  //   notifyListeners(); // 화면 갱신
  // }

  // void delete(String docId) async {
  //   // bucket 삭제
  //   await movieCollection.doc(docId).delete();
  //   notifyListeners(); // 화면 갱신
  // }
}
