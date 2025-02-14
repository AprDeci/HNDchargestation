import 'package:chargestation/app/areas.dart';
import 'package:chargestation/app/utils/Util.dart';
import 'package:chargestation/components/HomeListView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Homecontroller.dart';

class Home extends StatelessWidget {
  get tabcontroller => null;

  @override
  Widget build(context) {
    HomeController controller = Get.put(HomeController());
    List tabs = Areas.arealist_name;
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
              title: TabBar(
            controller: controller.tabcontroller,
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
          )),
          body: TabBarView(
              controller: controller.tabcontroller,
              children: Areas.arealist.map((e) {
                return HomeListView(e);
              }).toList()),
        ));
  }
}
