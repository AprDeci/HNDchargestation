import 'package:chargestation/request/HttpClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

class Util{
  static const version = 'v1.2.0';

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

  static Future checkUpdate(bool istap) async {
    if (istap) SmartDialog.showToast("检查更新ing",maskColor:Colors.white.withOpacity(0.5));
    Dio dio = Dio();
    var url = 'https://api.github.com/repos/AprDeci/HNDchargestation/releases/latest';
    try {
      var response = await dio.get(url);
      if(response.statusCode==200){
      if (parse_version(response.data['tag_name']) > parse_version(version)) {
       await Get.dialog(
          AlertDialog(
            title: Text("有新版本了-${response.data['tag_name']}",style: TextStyle(fontSize: 16),),
              content: Padding(
                  padding: EdgeInsets.all(6),
                  child: Container(
                    color: Colors.white70.withOpacity(0.5),
                    constraints: BoxConstraints(maxHeight: 200,),
                    child: SingleChildScrollView(
                      child: Text("${response.data['body']}"),
                    ))),
            actions: [
              TextButton(onPressed: ()=>Util.LlaunchUrl(Util.url_github_release), child: Text("Github")),
              TextButton(onPressed: ()=>Util.LlaunchUrl(Util.url_lanzou), child: Text("蓝奏云")),
              TextButton(onPressed: ()=>Get.back(), child: Text("取消"))
            ],
          )
        );
      }else{
        if (istap)SmartDialog.showToast("已经是最新版本了");
      }
      }
      }catch(e) {
        if (istap)SmartDialog.showToast("检查更新失败");
      }
    }

    static int parse_version(String version){
      int version_num=version.replaceAll('v', '').split('.').map((e) => int.parse(e)).reduce((a, b) => a * 1000 + b);
      return version_num;
    }
    }


