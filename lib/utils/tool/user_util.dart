import '../../models/login.m.dart';
import '../../models/auth.m.dart';
import './sp_util.dart';

const userInfoKey = 'userInfoKey';
const tokenKey = 'tokenKey';
const refreshTokenKey = 'refreshTokenKey';
const fullUserInfoKey = 'fullUserInfoKey'; // 完整用户信息

class UserUtil {
  /// 获取缓存用户信息
  static Future<LoginMobileData> getUserInfo() async {
    var spUtil = await SpUtil.getInstance();
    var cacheData = await spUtil.getData(userInfoKey) ?? {};
    return LoginMobileData.fromJson(cacheData.cast<String, dynamic>());
  }

  /// 保存用户信息
  static Future<void> saveUserInfo(LoginMobileData data) async {
    data.avatar = data.avatar?.replaceAll(RegExp(r'http://'), 'https://');
    var spUtil = await SpUtil.getInstance();
    await spUtil.setMapData(userInfoKey, data.toJson());
  }

  /// 清除用户信息缓存
  static Future<void> cleanUserInfo() async {
    var spUtil = await SpUtil.getInstance();
    await spUtil.remove(userInfoKey);
  }

  /// 获取token
  static Future<String> getToken() async {
    var userInfo = await getUserInfo();
    return userInfo.authorization ?? '';
  }

  /// 设置token
  static Future<void> setToken(String value) async {
    var userInfo = await getUserInfo();
    userInfo.authorization = value;
    await saveUserInfo(userInfo);
  }

  /// 清除token
  static Future<void> cleanToKen() async {
    var userInfo = await getUserInfo();
    userInfo.authorization = '';
    await saveUserInfo(userInfo);
  }

  // ==================== 新版 Token 管理 ====================

  /// 获取访问令牌（新版本）
  static Future<String> getAccessToken() async {
    var spUtil = await SpUtil.getInstance();
    return await spUtil.getData(tokenKey, defValue: '');
  }

  /// 保存访问令牌
  static Future<void> saveToken(String token) async {
    var spUtil = await SpUtil.getInstance();
    await spUtil.setData(tokenKey, token);
  }

  /// 获取刷新令牌
  static Future<String> getRefreshToken() async {
    var spUtil = await SpUtil.getInstance();
    return await spUtil.getData(refreshTokenKey, defValue: '');
  }

  /// 保存刷新令牌
  static Future<void> saveRefreshToken(String refreshToken) async {
    var spUtil = await SpUtil.getInstance();
    await spUtil.setData(refreshTokenKey, refreshToken);
  }

  /// 保存登录响应（包含 token 和 refreshToken）
  static Future<void> saveLoginRes(LoginResVO loginRes) async {
    if (loginRes.token != null) {
      await saveToken(loginRes.token!);
    }
    if (loginRes.refreshToken != null) {
      await saveRefreshToken(loginRes.refreshToken!);
    }
  }

  /// 清除所有认证信息
  static Future<void> cleanAuth() async {
    var spUtil = await SpUtil.getInstance();
    await spUtil.remove(tokenKey);
    await spUtil.remove(refreshTokenKey);
    await cleanUserInfo();
    await cleanFullUserInfo();
  }

  /// 检查是否已登录
  static Future<bool> isLogin() async {
    String token = await getAccessToken();
    return token.isNotEmpty;
  }

  // ==================== 完整用户信息管理 ====================

  /// 保存完整用户信息
  static Future<void> saveFullUserInfo(UserInfoVO userInfo) async {
    var spUtil = await SpUtil.getInstance();
    await spUtil.setMapData(fullUserInfoKey, userInfo.toJson());
  }

  /// 获取完整用户信息
  static Future<UserInfoVO?> getFullUserInfo() async {
    var spUtil = await SpUtil.getInstance();
    // 使用 getMap 方法获取并解析 JSON
    Map<String, dynamic>? cacheData = await spUtil.getMap<Map<String, dynamic>>(fullUserInfoKey);
    if (cacheData == null || cacheData.isEmpty) {
      return null;
    }
    try {
      return UserInfoVO.fromJson(cacheData);
    } catch (e) {
      // 解析失败，返回 null
      return null;
    }
  }

  /// 清除完整用户信息
  static Future<void> cleanFullUserInfo() async {
    var spUtil = await SpUtil.getInstance();
    await spUtil.remove(fullUserInfoKey);
  }
}
