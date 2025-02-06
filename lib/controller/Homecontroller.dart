import 'dart:convert';
import 'package:chargestation/app/areas.dart';
import 'package:chargestation/controller/Homelistcontroller.dart';
import 'package:chargestation/request/HttpClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabcontroller;

  HomeController(){
    tabcontroller = TabController(length: Areas.arealist.length, vsync: this);
  }

  @override
  void onInit() {

    // 为不同区域注入controller
    for(var area in Areas.arealist){
      Get.lazyPut(()=>HomeListController(area),tag: area.name);
    }

    super.onInit();
  }


}
