import 'package:chargestation/components/stationoverlook.dart';
import 'package:chargestation/controller/Mycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(home: Home()));
}

class Controller extends GetxController{
  var count = 0.obs;
  increment() => count++;
}
class Home extends StatelessWidget {

  @override
  Widget build(context) {
    Mycontroller controller = Get.put(Mycontroller());

    return Scaffold(
      appBar: AppBar(
        title: Text('河农大充电桩(兰亭苑)'),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: Obx(() {
      if (controller.Allstates.isEmpty) {
        return Center(child: CircularProgressIndicator()); // 显示加载指示器
      } else {
        return RefreshIndicator(
          onRefresh: () async{
            controller.getAllData();
          },
          child:
            ListView.builder(
            itemCount: controller.Allstates.length,
            itemBuilder: (context, index) {
              final state = controller.Allstates[index];
              return stationcard(state,"兰亭苑${index+1}号桩");
            },
        ));
      }}),
    );
  }

}
