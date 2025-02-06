import 'package:chargestation/app/areas.dart';
import 'package:chargestation/service/dbservice.dart';
import 'package:get/get.dart';

class settingpagecontroller extends GetxController{
  static settingpagecontroller get instance => Get.find<settingpagecontroller>();

  @override
  void onInit() {
    initAreas();
    super.onInit();
  }

  void initAreas(){
    var areas = dbservice.instance
        .getValue(dbservice.LareaList, Areas.areaMap.keys.join(','))
        .split(',');
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
    if (oldIndex < newIndex) newIndex-=1;
    final String item = arealist.removeAt(oldIndex);
    arealist.insert(newIndex, item);
    dbservice.instance.setValue(dbservice.LareaList, arealist.join(","));
  }

}