// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chargestation/app/areas.dart';
import 'package:chargestation/app/utils/Util.dart';
import 'package:chargestation/controller/Settingpagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chargestation/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  test('返回areaslist_name', (){
    List tabs = ["兰亭", "食堂", "XX"];
    //List tabss = Areas.arealist_name();
    //expect(tabss, tabs);
  });

  test('areamap',(){
    print(Areas.areaMap.keys.toList());
    print(settingpagecontroller.instance.arealist);
  });

  test('checkupdate',() async {
    await Util.checkUpdate(false);
  });

  test('parseversion', (){
    var con = Util.parse_version('1.2.3');
    print(con);
  });

  test('version',() async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    print(packageInfo.version);
  });
}
