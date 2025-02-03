
import 'package:chargestation/navigatorpage.dart';
import 'package:chargestation/page/Home.dart';
import 'package:chargestation/page/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

void main() async{
  runApp(GetMaterialApp(
      home: navigatorpage(),
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(name: '/home', page: ()=>Home()),
        GetPage(name: '/setting', page: ()=>SettingsPage())
      ],
    locale: const Locale("zh", "CN"),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale("zh", "CN")],
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
  ));
}

