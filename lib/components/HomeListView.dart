import 'package:chargestation/components/stationoverlook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../app/areas.dart';
import '../controller/Homelistcontroller.dart';
import 'KeepAliveWrapper.dart';

class HomeListView extends StatelessWidget{
  final Area area;

  const HomeListView(this.area,{Key? key}) : super(key: key);

  HomeListController get controller => Get.find<HomeListController>(tag: area.name);

  @override
  Widget build(BuildContext context) {

    return KeepAliveWrapper(child: Obx(() {
      if (!controller.hasloaded.value) {
      //if(true){
        // 加载界面
        return RefreshIndicator(
            onRefresh: ()async{
              controller.getAllstatus();
            },child:
          Skeletonizer(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                          title: const Text('The title goes here'),//占位
                          subtitle: Row(
                            children: List.generate(10, (index) {
                              return Container(
                                margin: EdgeInsets.all(4),
                                width: 25,
                                height: 25,
                                color: Colors.grey,
                              );
                            }),
                          )));
                }))); // 显示加载指示器
      } else {
        return RefreshIndicator(
            onRefresh: () async {
              controller.getAllstatus();
            },
            child: ListView.builder(
              itemCount: controller.allstates.length,
              itemBuilder: (context, index) {
                final state = controller.allstates[index + 1];
                return stationcard(state!, "兰亭苑${index + 1}号桩");
              },
            ));
      }
    }));


  }

}