import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:chargestation/app/areas.dart';
import 'package:chargestation/service/dbservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/utils/Util.dart';

class settingpagecontroller extends GetxController{
  static settingpagecontroller get instance => Get.find<settingpagecontroller>();

  @override
  void onInit() {
    Future.delayed(Duration.zero,checkfirstuse);
    initAreas();
    Util.checkUpdate(false);
    super.onInit();
  }

  void initAreas(){
    var areas = dbservice.instance
        .getValue(dbservice.LareaList, Areas.areaMap.keys.join(','))
        .split(',');
    print("初始化------$areas");
    if(areas.length != Areas.areaMap.length){
      var keys = Areas.areaMap.keys.toList();
      for(var i = 0; i < keys.length; i++){
        if(!areas.contains(keys[i])){
          areas.add(keys[i]);
        }
      }
    }
  arealist.value = areas;

  }

  RxList<String> arealist = <String>[].obs;
  void setAreaList(List<String> e){
    arealist.value = e;
    dbservice.instance.setValue(dbservice.LareaList, arealist.join(","));
  }

  void updateAreaList(int oldIndex, int newIndex){
    Aptabase.instance.trackEvent("拖拽排序");
    if (oldIndex < newIndex) newIndex-=1;
    final String item = arealist.removeAt(oldIndex);
    arealist.insert(newIndex, item);
    dbservice.instance.setValue(dbservice.LareaList, arealist.join(","));
  }

  void checkfirstuse() async{
    if (dbservice.instance.getValue(dbservice.Lfirstuse, true) == true) {
      dbservice.instance.setValue(dbservice.Lfirstuse, false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.dialog(
          AlertDialog(
          title: Text("该弹窗只显示一次",style: TextStyle(fontSize: 14),),
        content: ConstrainedBox(constraints: BoxConstraints(maxHeight: 400),child: SingleChildScrollView(child:
        Padding(padding: EdgeInsets.all(12),child:
        Text("学弟学妹们有能力给学长点个star吧,这对学长真的很重要🥺",style: TextStyle(fontSize: 14),),
        ))),
        actions: [
        TextButton(onPressed: (){Util.LlaunchUrl(Util.url_responsity);Get.back();}, child: Text("好的")),
        TextButton(onPressed: ()=>Get.back(), child: Text("不给"))
        ]));
      });

    }
  }

}