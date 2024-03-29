import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/model/dashboard_model.dart';

class DataService {
  Future<List<DashBoardModel>> fetchData() async {
    try {
      List<DashBoardModel> data = [];
      CollectionReference myCollection =
          FirebaseFirestore.instance.collection('Trending');

      QuerySnapshot snapshot = await myCollection.get();
      QuerySnapshot response2 = await FirebaseFirestore.instance
          .collection("shortnews")
          .where("language", isEqualTo: "en")
          .get();

      data = snapshot.docs
          .map((doc) => DashBoardModel(
                id: doc.id,
                description: doc['description'],
                heading: doc['heading'],
                img: doc['img'],
                news_id: doc['news_id'],
                news_link: doc['news_link'],
                title: doc['title'],
                video: doc['video'],
               // from: doc['from'],
              ))
          .toList();

      data.addAll(response2.docs
          .map((doc) => DashBoardModel(
                id: doc.id,
                description: doc['description'],
                heading: doc['heading'],
                img: doc['img'],
                news_id: doc['news_id'],
                news_link: doc['news_link'],
                title: doc['title'],
                video: doc['video'],
                //from: doc['from'],
              ))
          .toList());

      final jsonString =
          jsonEncode(data.map((model) => model.toJson()).toList());
      await sharedPref.setString('dashboardModels', jsonString);

      return data;
    } catch (e) {
      print("kdjfhjgdjdfggh  ${e}");
      throw e;
    }
  }

  Future<List<DashBoardModel>> fetchDataType(String newsType) async {
    List<DashBoardModel> data = [];
    CollectionReference myCollection =
        FirebaseFirestore.instance.collection('Trending');

    QuerySnapshot snapshot = await myCollection.get();
    QuerySnapshot response2 =
        await FirebaseFirestore.instance.collection("shortnews").get();

    data = snapshot.docs
        .map((doc) => DashBoardModel(
              id: doc.id,
              description: doc['description'],
              heading: doc['heading'],
              img: doc['img'],
              news_id: doc['news_id'],
              news_link: doc['news_link'],
              title: doc['title'],
              video: doc['video'],
              from: doc['from'],
            ))
        .toList();
    return data;
  }
}
