
import 'package:chargestation/navigatorpage.dart';
import 'package:chargestation/page/Home.dart';
import 'package:chargestation/page/SettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;


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

