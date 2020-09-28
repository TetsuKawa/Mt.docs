import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_ad_manager/ad_size.dart';
import 'package:flutter_google_ad_manager/banner.dart';
import 'package:flutter_google_ad_manager/test_devices.dart';

class Ads{
  static DFPBannerViewController _bannerViewController;

  _reload() {
    _bannerViewController?.reload();
  }

  static String getAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2623375152547298~3700771435';
    }
    else if (Platform.isAndroid) {
      return 'ca-app-pub-2623375152547298~5495061228';
    }
    return null;
  }

  static String getBannerAdUnitId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-2623375152547298/9406386077';
    }
    else if (Platform.isAndroid) {
      return 'ca-app-pub-2623375152547298/1555816210';
    }
    return null;
  }

  Widget getBanner(){
    return Center(
      child: DFPBanner(
        isDevelop: false,
        testDevices: MyTestDevices(),
        adUnitId: getBannerAdUnitId(),
        adSize: DFPAdSize.BANNER,
        onAdLoaded: () {
          print('Banner onAdLoaded');
        },
        onAdFailedToLoad: (errorCode) {
          print('Banner onAdFailedToLoad: errorCode:$errorCode');
          _reload();
        },
        onAdOpened: () {
          print('Banner onAdOpened');
        },
        onAdClosed: () {
          print('Banner onAdClosed');
        },
        onAdLeftApplication: () {
          print('Banner onAdLeftApplication');
        },
        onAdViewCreated: (controller){
          _bannerViewController = controller;
        },
      ),
    );
  }
}


class MyTestDevices extends TestDevices {
  static MyTestDevices _instance;
  factory MyTestDevices() {
    if (_instance == null) _instance = new MyTestDevices._internal();
    return _instance;
  }
  MyTestDevices._internal();
  @override
  List<String> get values => List()..add("00008020-001431E41EF8003A")
    ..add('FA7911A00445');
}