import 'dart:convert';

import 'package:chargestation/request/HttpClient.dart';
import 'package:get/get.dart';


class Mycontroller extends GetxController{

 @override
  void onInit() {
    getAllData();
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

  void getData(id) async{
    var response = await httpclient.post({
      "code":id,
      "parentCode":null,
      "timestamp":(DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString()
    },headers);
    states.value = json.decode(response);
  }

Future<void> getAllData() async{
    Allstates.clear();
    for(String id in ids){
      try {
        var response = await httpclient.post({
          "code": id,
          "parentCode": null,
          "timestamp": (DateTime
              .now()
              .toUtc()
              .millisecondsSinceEpoch ~/ 1000).toString()
        }, headers);
        Allstates.add(response);
      } catch (e) {
        print("Getallstates-Error-${e}");
      }

    }
    print(Allstates);
}
  final ids = ["4GR00007971","4GR00007972","4GR00007973","4GR00007974","4GR00007975","4GR00007976","4GR00007977","4GR00007978","4GR00007979","4GR00007980","4GR00007981"];

  final states = <String,dynamic>{}.obs;

  final Allstates = <Map<String,dynamic>>[].obs;

}