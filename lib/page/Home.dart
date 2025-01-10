import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/KeepAliveWrapper.dart';
import '../components/stationoverlook.dart';
import '../controller/Mycontroller.dart';

class Home extends StatelessWidget {
  get tabcontroller => null;

  @override
  Widget build(context) {
    Mycontroller controller = Get.put(Mycontroller());
    List tabs = ["兰亭", "食堂", "XX"];
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
              title: TabBar(
            controller: tabcontroller,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          )),
          body: TabBarView(
              children: tabs.map((e) {
            return KeepAliveWrapper(
              child: Obx(() {
                if (controller.Allstates.isEmpty) {
                  return Center(child: CircularProgressIndicator()); // 显示加载指示器
                } else {
                  return RefreshIndicator(
                      onRefresh: () async {
                        controller.getAllData();
                      },
                      child: ListView.builder(
                        itemCount: controller.Allstates.length,
                        itemBuilder: (context, index) {
                          final state = controller.Allstates[index];
                          return stationcard(state, "兰亭苑${index + 1}号桩");
                        },
                      ));
                }
              }),
            );
          }).toList()),
        ));
  }
}
