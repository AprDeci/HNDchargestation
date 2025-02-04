import 'dart:convert';
import 'package:chargestation/app/areas.dart';
import 'package:chargestation/controller/Homelistcontroller.dart';
import 'package:chargestation/request/HttpClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabcontroller;

  HomeController(){
    tabcontroller = TabController(length: Areas.areaList.length, vsync: this);
  }

  @override
  void onInit() {

    // 为不同区域注入controller
    for(var area in Areas.areaList){
      Get.put(HomeListController(area),tag: area.name);
    }


    super.onInit();
  }

  final httpclient = Httpclient();

  final Map<String, String> headers = {
    'User-Agent':
        'Mozilla/5.0 (Linux; Android 14; MEIZU 20 Build/UKQ1.230917.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/130.0.6723.103 Mobile Safari/537.36 XWEB/1300259 MMWEBSDK/20241103 MMWEBID/5216 MicroMessenger/8.0.55.2780(0x2800373D) WeChat/arm64 Weixin NetType/WIFI Language/zh_CN ABI/arm64',
    'Accept-Encoding': 'gzip, deflate, br, zstd',
    'sec-ch-ua-platform': '"Android"',
    'sec-ch-ua':
        '"Chromium";v="130", "Android WebView";v="130", "Not?A_Brand";v="99"',
    'Content-Type': 'application/json;charset=UTF-8',
    'sec-ch-ua-mobile': '?1',
    'Origin': 'https://wx.isfdz.com',
    'X-Requested-With': 'com.tencent.mm',
    'Sec-Fetch-Site': 'same-origin',
    'Sec-Fetch-Mode': 'cors',
    'Sec-Fetch-Dest': 'empty',
    'Referer': 'https://wx.isfdz.com/',
    'Accept-Language': 'zh-CN,zh;q=0.9,en-US;q=0.8,en;q=0.7',
  };

  void getData(id) async {
    var response = await httpclient.getStationInfo({
      "code": id,
      "parentCode": null,
      "timestamp":
          (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString()
    }, headers, "lanting");
    states.value = json.decode(response);
  }


  Future<void> getAllData() async {
    hasloaded_lt.value = false;
    allstates_lt.clear();
    // 使用 map 创建一个 Future 列表，并用 Future.wait 并发执行它们
    List<Future> futures = ids_lt.entries.map((id) async {
      try {
        var response = await httpclient.getStationInfo({
          "code": id.value,
          "parentCode": null,
          "timestamp": (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString()
        }, headers, "lanting");
        allstates_lt[id.key] = response;
      } catch (e) {
        print("Getallstates-Error-${e}");
      }
    }).toList();

    // 等待所有 Future 完成
    await Future.wait(futures);

    hasloaded_lt.value=true;

    print(allstates_lt.toString());

  }


  final ids_lt = {
    1:"4GR00007971",
    2:"4GR00008013",
    3:"4GR00007975",
    4:"4GR00007977",
    5:"4GR00008014",
    6:"4GR00007974",
    7:"4GR00007996",
    8:"4GR00007992",
    9:"4GR00008016",
    10:"4GR00007973",
    11:"4GR00007978",
    12:"4GR00007994"
  };

  final states = <String, dynamic>{}.obs;

  final Allstates = <Map<String, dynamic>>[].obs;

  final allstates_lt  = <int,Map<String, dynamic>>{}.obs;

  final hasloaded_lt = true.obs;

  final lanting_states = <Map<String, dynamic>>{}.obs;

}
