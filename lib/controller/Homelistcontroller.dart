
import 'dart:math';

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

    final random = Random();
    int maxRetries = 2;
    int concurrentLimit = area.ids.length; // 新增并发控制参数

    // 将请求任务包装为可执行函数列表
    final tasks = area.ids.entries.map((entry) => () async {
      final idKey = entry.key;
      final idValue = entry.value;
      int attempt = 0;
      bool success = false;

      while (attempt < maxRetries && !success) {
        attempt++;
        try {
          final response = await httpclient.getStationInfo({
            "code": idValue,
            "parentCode": null,
            "timestamp": (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000).toString()
          }, headers);
          allstates[idKey] = response;
          success = true;
        } catch (e) {
          if (attempt == maxRetries) {
            print("⚠️ 关键错误: ID $idKey 最终失败 - ${e.toString()}");
            allstates[idKey] = {"error": "请求超时"};
          } else {
            final backoffTime = (pow(2, attempt) * 1000 + random.nextInt(500)).toInt();
            await Future.delayed(Duration(milliseconds: backoffTime));
          }
        }
      }
    }).toList();

    // 分批次执行
    for (var i = 0; i < tasks.length; i += concurrentLimit) {
      final batch = tasks.sublist(
          i,
          i + concurrentLimit > tasks.length ? tasks.length : i + concurrentLimit
      );

      // 等待当前批次全部完成
      await Future.wait([
        for (final task in batch)
          task().catchError((e) => print("批处理错误: $e"))
      ]);
    }

    hasloaded.value = true;
    print(allstates.keys);
    print("✅ 加载完成，成功获取 ${allstates.length}/${area.ids.length} 个状态");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    print("----------${area.name}初始化");
    getAllstatus();
    super.onInit();
  }




}