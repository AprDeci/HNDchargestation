// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chargestation/app/areas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chargestation/main.dart';

void main() {
  test('返回areaslist_name', (){
    List tabs = ["兰亭", "食堂", "XX"];
    List tabss = Areas.arealist_name();
    expect(tabss, tabs);
  });
}
