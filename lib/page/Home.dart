import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../components/KeepAliveWrapper.dart';
import '../components/stationoverlook.dart';
import '../controller/Mycontroller.dart';

class Home extends StatelessWidget {
  get tabcontroller => null;

  @override
  Widget build(context) {
    HomeController controller = Get.put(HomeController());
    List tabs = ["兰亭", "食堂", "XX"];
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
              title: TabBar(
            controller: tabcontroller,
            tabs: tabs.map((e) => Tab(text: e,)).toList(),
          )),
          body: TabBarView(
              children: tabs.map((e) {
            return KeepAliveWrapper(child: Obx(() {
              if (!controller.hasloaded_lt.value) {
                // 加载界面
                return Skeletonizer(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                              title: const Text('The title goes here'),
                          subtitle: Row(
                              children: List.generate(10, (index) {
                                return Container(
                                  margin: EdgeInsets.all(4),
                                  width: 25,
                                  height: 25,
                                  color: Colors.grey,
                                );
                              }),
                          )
                          ));
                        })); // 显示加载指示器
              } else {
                return RefreshIndicator(
                    onRefresh: () async {
                      controller.getAllData();
                    },
                    child: ListView.builder(
                      itemCount: controller.allstates_lt.length,
                      itemBuilder: (context, index) {
                        final state = controller.allstates_lt[index+1];
                        return stationcard(state!, "兰亭苑${index + 1}号桩");
                      },
                    ));
              }
            }));
          }).toList()),
        ));
  }
}
