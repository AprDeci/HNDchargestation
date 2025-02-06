import 'package:chargestation/app/areas.dart';
import 'package:hive/hive.dart';

class dbutil{

  static List<Area> getarealist()  {
    var box = Hive.box('settingbox');
    print("取数据");
    print(box.get("arealist")[0]);
    return box.get("arealist") ?? [];
  }
}