import 'package:get/get.dart';
import 'package:hive/hive.dart';

class dbservice extends GetxService{

  static dbservice get instance => Get.find<dbservice>();

  static const String LareaList = "areaList";

  late Box settingBox;

  Future init() async{
    settingBox = await Hive.openBox("settingbox");
  }

  T getValue<T>(dynamic key,T defaultValue){
    try{
      var value = settingBox.get(key,defaultValue: defaultValue);
      print("get settingbox: $key : $value");
      return value;
    }catch(e){
      print("get settingbox error: $e");
      return defaultValue;
    }
  }
  Future setValue<T>(dynamic key,T value) async {
    print("set settingbox: $key : $value");
    return await settingBox.put(key,value);
  }
  Future removeValue(dynamic key) async {
    print("remove settingbox: $key");
    return await settingBox.delete(key);
  }


}