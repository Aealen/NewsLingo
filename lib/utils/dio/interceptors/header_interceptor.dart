import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:NewsLingo/config/app_config.dart';
import '../../tool/user_util.dart';

/*
 * header拦截器
 */
class HeaderInterceptors extends InterceptorsWrapper {
  // 请求拦截
  @override
  onRequest(RequestOptions options, handler) async {
    options.baseUrl = AppConfig.host;

    // 自动添加 token
    String token = await UserUtil.getAccessToken();
    if (token.isNotEmpty) {
      if (kIsWeb) {
        // Web 环境：将 token 作为查询参数，避免触发 CORS 预检请求
        // Sa-Token 支持 satoken 参数传递
        options.queryParameters['satoken'] = token;
      } else {
        // 移动端：使用 Authorization header
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    return handler.next(options);
  }

  // 响应拦截
  @override
  onResponse(response, handler) {
    // Do something with response data
    return handler.next(response); // continue
  }

  // 请求失败拦截
  @override
  onError(err, handler) async {
    return handler.next(err); //continue
  }
}
