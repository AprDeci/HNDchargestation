import 'package:chargestation/controller/Settingpagecontroller.dart';
import 'package:hive/hive.dart';
part 'areas.g.dart';
class Areas {
  static final Map<String, Area> areaMap = {
    "lanting": Area(
      MM: '',
      name: '兰亭',
      ids: {
        1: "4GR00007971",
        2: "4GR00008013",
        3: "4GR00007975",
        4: "4GR00007977",
        5: "4GR00007978",
        6: "4GR00008016",
        7: "4GR00007974",
        8: "4GR00007996",
        9: "4GR00008014",
        10: "4GR00007994",
        11: "4GR00007992",
        12: "4GR00007973"
      },
    ),
    "shitang": Area(MM: '(东南角顺时针)', name: '二食堂',ids: {
      1:"4GR00009820",
      2:"4GR00009377",
      3:"4GR00009460",
      4:"4GR00009456",
      5:"4GR00009381",
      6:"4GR00009366"
    }),
    "xingzhenglou": Area(MM: '(从左向右)', name: '行政楼',ids: {
      1:"4GR00009364",
      2:"4GR00009822",
  })
  };

  static List<Area> get arealist {
    return settingpagecontroller.instance.arealist
        .map((e) => areaMap[e]!)
        .toList();
  }

  static List<String> get arealist_name {
    return settingpagecontroller.instance.arealist
        .map((e) => areaMap[e]!.name)
        .toList();
  }
}

@HiveType(typeId: 1)
class Area {

  @HiveField(0)
  String MM; //英文简写
  @HiveField(1)
  String name;
  @HiveField(2)
  Map ids;

  Area({required this.MM, required this.name, this.ids = const {}});


}
