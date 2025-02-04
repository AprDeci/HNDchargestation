class Areas {
  static final List<Area> areaList = [
    Area(
      'lanting',
      '兰亭',
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
    Area('shitang', '食堂'),
    Area('XX', 'XX'),
  ];

  static List<String> arealist_name() {
    return areaList.map((e) => e.name).toList();
  }
}

class Area {
  String MM; //英文简写
  String name;
  Map ids;

  Area(this.MM, this.name, {this.ids = const {}});
}
