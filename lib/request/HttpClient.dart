import 'package:chargestation/request/AppException.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


class Httpclient {

  static Httpclient? _instance;

  factory Httpclient() => _instance ??= Httpclient._internal();

  static Httpclient? get instance => _instance ?? Httpclient._internal();

  static Dio _dio = Dio();

  Httpclient._internal(){
    BaseOptions baseOptions = BaseOptions(
      baseUrl: 'https://wx.isfdz.com/api/',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    );
    _instance = this;
    _dio = Dio(baseOptions);
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: _onResponse,
      onError: _onError,
    ));
  }
  void _onResponse(Response response, ResponseInterceptorHandler handler) async {
    // 请求成功是对数据做基本处理
    if (response.statusCode == 200) {
      // 处理成功的响应
      print("响应结果: $response");
    } else {
      // 处理异常结果
      print("响应异常: $response");
    }
    handler.next(response);
  }

  /// 错误处理: 网络错误等
  void _onError(DioException error, ErrorInterceptorHandler handler) {
    AppException appException = AppException.create(error);
    debugPrint("DIOerror: $appException");
    return handler.next(error);
  }



  getStationInfo(Map data, Map<String,String> headers) async{
    try {
        Response response = await _dio.post(
            '/equi/afterProtocol/getLineInfo',
            data: data,
            options: Options(
                headers: headers, followRedirects: false));
        if (response.statusCode == 200) {
          return response.data;
        } else {
          return "lose";
        }
    }catch(e){
      print("getstaitioninfo异常:${e}");
    }
  }

}



