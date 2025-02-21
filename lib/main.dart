
import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:chargestation/controller/Settingpagecontroller.dart';
import 'package:chargestation/navigatorpage.dart';
import 'package:chargestation/page/Home.dart';
import 'package:chargestation/page/SettingsPage.dart';
import 'package:chargestation/service/dbservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app/areas.dart';
import 'app/utils/Util.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(AreaAdapter());

  await Get.put(dbservice()).init();
  Get.put(settingpagecontroller());

  WidgetsFlutterBinding.ensureInitialized();
  await Aptabase.init("A-US-4114330648");

  Aptabase.instance.trackEvent("启动应用");

  Util.packageInfo = await PackageInfo.fromPlatform();

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

