import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortnews/main.dart';
import 'package:shortnews/model/dashboard_model.dart';
import 'package:shortnews/view/uitl/apphelper.dart';
import 'package:shortnews/view_model/data_service.dart';
import 'package:url_launcher/url_launcher.dart';

class MyController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final DataService _dataService = DataService();
  var myData = <DashBoardModel>[].obs;
  var internet = false.obs;
  var light = true.obs;
  var notification = true.obs;
  var showpop = false.obs;
  List<Map<String, dynamic>> list = [
    {"icon": Icons.ac_unit_sharp, "type": "My Feed"},
    {"icon": Icons.account_balance_outlined, "type": "All News"},
    {"icon": Icons.star, "type": "Top Stories"},
    {"icon": Icons.trending_up_outlined, "type": "Trending"},
    {"icon": Icons.bookmark, "type": "Book Mark"},
    {"icon": Icons.timer_10_select_sharp, "type": "Technology"},
    {"icon": Icons.real_estate_agent_rounded, "type": "Entertainment"},
    {"icon": Icons.sports_baseball_outlined, "type": "Sports"},
  ];
  var isclick = false.obs;

  @override
  void onInit() {
    getData();
    setupRemoteConfig();
    super.onInit();
  }


  void fetchData() async {



    try {
      myData.value = await _dataService.fetchData();
    } catch (e) {
    } 
  }

  void fetchParticularData(String newsType) async {
    try {
      myData.value = await _dataService.fetchDataType(newsType);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  getData() async {
    bool result = await InternetConnectionChecker().hasConnection;
    internet.value = result;
    if (result == true) {
      fetchData();
      //  loadModelsFromPrefs();
    } else {
      // loadModelsFromPrefs();
    }
  }

//-------------------------load data from local--------------------------//
  loadModelsFromPrefs() async {
    final jsonString = sharedPref.getString('dashboardModels');
    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      myData.value =
          jsonList.map((json) => DashBoardModel.fromJson(json)).toList();
    }
  }
}

//---------------------------------    Remote config          ----------------------------------------------//

setupRemoteConfig() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  final remoteConfig = FirebaseRemoteConfig.instance;

  remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration.zero));
  await remoteConfig.fetch();
  await remoteConfig.activate();

  if (remoteConfig.getValue("appUpdate").asBool()) {
    if (version != remoteConfig.getValue("Version").asString() &&
        remoteConfig.getValue("forceFully").asBool()) {
      _forceFullyupdate(remoteConfig.getString("updateUrl"),
          remoteConfig.getString("updateMessage"));
      return;
    }
    if (version != remoteConfig.getValue("Version").asString()) {
      _update(remoteConfig.getString("updateUrl"),
          remoteConfig.getString("updateMessage"));
      return;
    }
  }
}

void _update(String url, String Message) {
  showCupertinoDialog(
      context: Get.context!,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
          title: const Text('Update ! '),
          content: Text(Message),
          actions: [
            // The "Yes" button
            CupertinoDialogAction(
              onPressed: () {
                Get.back();
              },
              child: const Text('May be later'),
              isDefaultAction: true,
              isDestructiveAction: true,
            ),
            // The "No" button
            CupertinoDialogAction(
              onPressed: () {
                _lunchInBrowser(url);
              },
              child: const Text('Update'),
              isDefaultAction: false,
              isDestructiveAction: false,
            )
          ],
        );
      });
}

void _forceFullyupdate(
  String url,
  String Message,
) {
  showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (BuildContext ctx) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: CupertinoAlertDialog(
            insetAnimationCurve: Curves.easeInOutCubic,
            insetAnimationDuration: Duration(milliseconds: 600),
            title: const Text(
              'Update required !',
            ),
            content: Text(Message),
            actions: [
              // The "Yes" button

              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  _lunchInBrowser(url);
                },
                child: const Text('Update'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          ),
        );
      });
}

Future<void> _lunchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{"headesr_key": "headers_value"});
  } else {
    throw "url not lunched $url";
  }
}
