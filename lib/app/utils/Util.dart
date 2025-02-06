import 'package:url_launcher/url_launcher.dart';

class Util{

  static final Uri url_blog = Uri.parse('https://www.aprdec.top');
  static final Uri url_github = Uri.parse('https://github.com/aprdeci');
  static final Uri url_responsity = Uri.parse('https://github.com/AprDeci/HNDchargestation');

  static Future<void> LlaunchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('不能打开 $url');
    }
  }

}