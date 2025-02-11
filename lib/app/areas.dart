import 'package:chargestation/controller/Settingpagecontroller.dart';
import 'package:hive/hive.dart';
part 'areas.g.dart';
class Areas {
  static final Map<String, Area> areaMap = {
    "lanting": Area(
      MM: 'lanting',
      name: '兰亭',
      ids: {
        1: "4GR00007971",
        2: "4GR00008013",
        3: "4GR00007975",
        4: "4GR00007977",
        5: "4GR00008014",
        6: "4GR00007974",
        7: "4GR00007996",
        8: "4GR00007992",
        9: "4GR00008016",
        10: "4GR00007973",
        11: "4GR00007978",
        12: "4GR00007994"
      },
    ),
    "shitang": Area(MM: 'shitang', name: '食堂'),
    "XX": Area(MM: 'XX', name: 'XX'),
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
