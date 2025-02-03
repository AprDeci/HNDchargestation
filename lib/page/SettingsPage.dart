import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {

  final Uri url_blog = Uri.parse('https://www.aprdec.top');
  final Uri url_github = Uri.parse('https://github.com/aprdeci');

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('不能打开 $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(4),
        children: <Widget>[
          ListTile(
            leading: Image.asset(
              'assets/love.jpg',
              width: 56,
              height: 56,),
            title: Text('河农大充电桩查看器',style: TextStyle(height: 1.0,fontSize: 16)),
            subtitle: Text('求求学弟学妹了给个star吧',style: TextStyle(height: 1.0,fontSize: 10),),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Get.dialog(AboutDialog(
                applicationIcon: Image.asset(
                  'assets/love.jpg',
                  width: 48,
                  height: 48,
                ),
                applicationName: "河农大充电桩查看器",
                applicationVersion: "简简单单看直播",
                applicationLegalese: "Ver 1.1",
              ));
            },
          ),
          Divider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.withOpacity(.1),
          ),
          ListTile(
            leading: Icon(SimpleIcons.github,color: SimpleIconColors.github,),
            title: Text('项目地址'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              _launchUrl(url_github);
            },
          ),
          ListTile(
            leading: Icon(SimpleIcons.notion,color: SimpleIconColors.notion),
            title: Text('学长博客'),
            onTap: () {
              _launchUrl(url_blog);
            },
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            leading: Icon(Icons.accessibility_new_rounded),
            title: Text('感谢名单'),
            onTap: () {
             Get.dialog(
               AlertDialog(
                 title: Text('感谢名单'),
                 content: Text('谢谢软件21-3班李继鹏和我一起扫码记录ID'),
                 actions: [
                   TextButton(
                     onPressed: (() => Get.back(result: false)),
                     child: Text("取消"),
                   ),
                   TextButton(
                     onPressed: (() => Get.back(result: true)),
                     child: Text("确定"),
                   ),
                 ],
               )
             );
            },
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}


