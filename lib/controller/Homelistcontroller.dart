import 'package:chargestation/app/areas.dart';
import 'package:get/get.dart';

import '../request/HttpClient.dart';

class HomeListController extends GetxController{
  final Area area;

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

  final allstates  = <int,Map<String, dynamic>>{}.obs;

  final hasloaded = false.obs;

  HomeListController(this.area);

  Future<void> getAllstatus() async {

    allstates.clear();

    hasloaded.value = false;

    List<Future> futures = area.ids.entries.map((id) async {
      try {
        var response = await httpclient.getStationInfo({
          "code": id.value,
          "parentCode": null,
          "timestamp": (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString()
        }, headers, "lanting");
        allstates[id.key] = response;
      } catch (e) {
        print("Getallstates-Error-${e}");
      }
    }).toList();

    await Future.wait(futures);

    hasloaded.value=true;

    print("加载完毕:--------------------------${allstates.toString()}");

  }

  @override
  void onInit() {
    // TODO: implement onInit
    print("----------${area.name}初始化");
    super.onInit();
  }




}