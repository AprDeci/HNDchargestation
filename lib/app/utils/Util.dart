import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

class Util{

  static final Uri url_blog = Uri.parse('https://www.aprdec.top');
  static final Uri url_github = Uri.parse('https://github.com/aprdeci');
  static final Uri url_responsity = Uri.parse('https://github.com/AprDeci/HNDchargestation');
  static final Uri url_lanzou = Uri.parse('https://wwqw.lanzouu.com/b007t784sf');
  static final Uri url_github_release = Uri.parse('https://github.com/AprDeci/HNDchargestation/releases');

  static Future<void> LlaunchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('不能打开 $url');
    }
  }

  static Future showDialog(BuildContext context, String title, String content, {String? btnText1,String? btnText2}) {
    return Get.dialog(
        AlertDialog(
            title: Text(title,style: TextStyle(fontSize: 14),),
            content: ConstrainedBox(constraints: BoxConstraints(maxHeight: 400),child: SingleChildScrollView(child:
            Padding(padding: EdgeInsets.all(12),child:
            Text(content,style: TextStyle(fontSize: 14),),
            ))),
            actions: [
              TextButton(onPressed: ()=>Util.LlaunchUrl(Util.url_responsity), child: Text("好的")),
              TextButton(onPressed: ()=>Get.back(), child: Text("不给"))
            ]));
  }
}