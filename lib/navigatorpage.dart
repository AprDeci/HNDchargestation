
import 'package:chargestation/page/Home.dart';
import 'package:chargestation/page/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 导航页
class navigatorpage extends StatelessWidget{

  // 导航控制器
  navigatorController navigatorcontroller = Get.put(navigatorController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 底部导航栏
      bottomNavigationBar: Theme(data: ThemeData(
        splashColor: Colors.transparent,
    ), child: Obx(()=>BottomNavigationBar(
          // 选中的字体大小
          selectedFontSize: 14,
          // 未选中的字体大小
          unselectedFontSize: 14,

          // 显示选中的文字
          showSelectedLabels: false,
          // 显示不选中时的问题
          showUnselectedLabels: false,
          // 导航栏项
          items: const [
            BottomNavigationBarItem(icon:Icon(Icons.home),label: "主页"),
            BottomNavigationBarItem(icon:Icon(Icons.settings),label: "设置"),
          ],
          // 当前选中的索引
          currentIndex: navigatorcontroller.selectedIndex.value,
        onTap:(index)=>{
            // 更新选中的索引
            navigatorcontroller.selectedIndex.value = index
        },
      ))),
      // 页面内容
      body: Obx(()=>navigatorcontroller.pages[navigatorcontroller.selectedIndex.value]),
    );
  }

}


class navigatorController extends GetxController {

  final Rx<int> selectedIndex = 0.obs;
  // 当前选中的索引

  RxList<Widget> pages = [Home(),SettingsPage()].obs;

}