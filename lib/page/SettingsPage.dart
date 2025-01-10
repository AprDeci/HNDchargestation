import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {

  final Uri _url = Uri.parse('https://www.aprdec.top');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://www.helloimg.com/i/2025/01/09/677f75ebe7543.jpg'),
                ),
              ),
            )
          ),
          ListTile(
            leading: Icon(Icons.abc),
            title: Text('可能以后会更新,所以加一个这个页面备用吧,点击打开我的博客哦(www.aprdec.top)'),
            onTap: () {
              _launchUrl();
            },
          ),
        ],
      ),
    );
  }
}

