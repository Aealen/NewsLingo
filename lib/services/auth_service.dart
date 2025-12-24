import '../models/auth.m.dart';
import '../utils/dio/request.dart' show Request;

/// 认证相关服务
class AuthService {
  /// 用户登录
  ///
  /// [loginDto] 登录参数
  /// 返回登录响应数据，包含 token 和 refreshToken
  static Future<RLoginResVO> doLogin(LoginDTO loginDto) async {
    final res = await Request.post<Map<String, dynamic>>(
      '/auth/doLogin',
      data: loginDto.toJson(),
    );
    return RLoginResVO.fromJson(res);
  }

  /// 用户注册
  ///
  /// [registerDto] 注册参数
  /// 返回注册结果
  static Future<RString> register(RegisterAddDTO registerDto) async {
    final res = await Request.post<Map<String, dynamic>>(
      '/auth/register',
      data: registerDto.toJson(),
    );
    return RString.fromJson(res);
  }

  /// 用户注销
  ///
  /// 返回注销结果
  static Future<RString> logout() async {
    final res = await Request.post<Map<String, dynamic>>('/auth/logout');
    return RString.fromJson(res);
  }

  /// 获取用户信息
  ///
  /// 返回用户信息数据
  static Future<RUserInfoVO> getUserInfo() async {
    final res = await Request.get<Map<String, dynamic>>(
      '/auth/getUserInfo',
    );
    return RUserInfoVO.fromJson(res);
  }
}
