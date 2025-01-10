import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../components/stationoverlook.dart';
import '../controller/Mycontroller.dart';

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
