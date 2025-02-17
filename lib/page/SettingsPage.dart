import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:chargestation/app/utils/Util.dart';
import 'package:chargestation/controller/Settingpagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app/areas.dart';

class SettingsPage extends StatelessWidget {

  final Uri url_blog = Uri.parse('https://www.aprdec.top');
  final Uri url_github = Uri.parse('https://github.com/aprdeci');
  final settingpagecontroller controller = Get.find();

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
            subtitle: Text('赶快去看《败犬女主太多了!》',style: TextStyle(height: 1.0,fontSize: 10),),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Get.dialog(AboutDialog(
                applicationIcon: Image.asset(
                  'assets/love.jpg',
                  width: 48,
                  height: 48,
                ),
                applicationName: "河农大充电桩查看器",
                applicationVersion: "赶快去看《败犬女主太多了!》",
                applicationLegalese: Util.version,
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
              Aptabase.instance.trackEvent("github");
              _launchUrl(Util.url_responsity);
            },
          ),
          // 下载页面
          ListTile(
            leading: Icon(Icons.download_rounded),
            title: Text('下载地址'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Aptabase.instance.trackEvent("下载地址");
              Get.dialog(
                AlertDialog(
                  content: Text("下载地址"),
                  actions: [
                    TextButton(
                      child: Text("云盘(密码aapr)"),
                      onPressed: () {
                        Util.LlaunchUrl(Util.url_lanzou);
                      }
                    ),
                    TextButton(
                        onPressed: (){
                          Util.LlaunchUrl(Util.url_github_release);
                        },
                        child: Text("Github_release"))
                  ]
                )
              );
    }
          ),
          ListTile(
            leading: Icon(Icons.upcoming),
            title: Text('检查更新'),
            trailing: Text('${Util.version}'),
            onTap: (){
              Util.checkUpdate(true);
            },
          ),
          Divider(
            indent: 12,
            endIndent: 12,
            color: Colors.grey.withOpacity(.1),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Text('区域排序(长按拖动排序,重启后生效)',style: Get.textTheme.titleSmall,),
          ),
          ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 60.0*Areas.arealist.length
              ),
              child:
          Card.filled(color: Colors.white54.withOpacity(.7),
              shadowColor: Colors.black.withOpacity(1),
              child:Obx(()=>
          ReorderableListView(
              physics: const NeverScrollableScrollPhysics(),
            onReorder: controller.updateAreaList,
            children: Areas.arealist.map((e) => ListTile(
                title: Text(e.name,style: TextStyle(fontSize: 14),),
                trailing: Icon(Icons.drag_handle,color: Colors.grey,),
                key: Key(e.name),
            )).toList()
          ))
          ))
        ],
      ),
    );
  }
}



