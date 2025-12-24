// 认证相关数据模型

// ==================== 通用响应模型 ====================

class R<T> {
  int? code;
  String? msg;
  T? data;

  R({this.code, this.msg, this.data});

  R.fromJson(Map<String, dynamic> json, T Function(dynamic)? dataParser) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null && dataParser != null) {
      data = dataParser(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = data;
    }
    return data;
  }

  bool get isSuccess => code == 200 || code == 0;
}

// ==================== 登录相关 ====================

/// 登录请求参数
class LoginDTO {
  String? userName;
  String? phone;
  String? password;
  String? captcha;
  bool? encrypted;

  LoginDTO({this.userName, this.phone, this.password, this.captcha, this.encrypted});

  LoginDTO.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phone = json['phone'];
    password = json['password'];
    captcha = json['captcha'];
    encrypted = json['encrypted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userName != null) data['userName'] = userName;
    if (phone != null) data['phone'] = phone;
    if (password != null) data['password'] = password;
    if (captcha != null) data['captcha'] = captcha;
    if (encrypted != null) data['encrypted'] = encrypted;
    return data;
  }
}

/// 登录响应数据
class LoginResVO {
  String? token;
  String? refreshToken;

  LoginResVO({this.token, this.refreshToken});

  LoginResVO.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

/// 登录响应
class RLoginResVO {
  int? code;
  String? msg;
  LoginResVO? data;

  RLoginResVO({this.code, this.msg, this.data});

  RLoginResVO.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? LoginResVO.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  bool get isSuccess => code == 200 || code == 0;
}

// ==================== 注册相关 ====================

/// 注册请求参数
class RegisterAddDTO {
  String? userName;
  String? password;
  bool? encrypted;
  String? phone;
  String? avatar;
  String? nickname;
  String? signature;
  int? sex;
  String? birthday;
  String? email;

  RegisterAddDTO({
    this.userName,
    this.password,
    this.encrypted,
    this.phone,
    this.avatar,
    this.nickname,
    this.signature,
    this.sex,
    this.birthday,
    this.email,
  });

  RegisterAddDTO.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    encrypted = json['encrypted'];
    phone = json['phone'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    signature = json['signature'];
    sex = json['sex'];
    birthday = json['birthday'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userName != null) data['userName'] = userName;
    if (password != null) data['password'] = password;
    if (encrypted != null) data['encrypted'] = encrypted;
    if (phone != null) data['phone'] = phone;
    if (avatar != null) data['avatar'] = avatar;
    if (nickname != null) data['nickname'] = nickname;
    if (signature != null) data['signature'] = signature;
    if (sex != null) data['sex'] = sex;
    if (birthday != null) data['birthday'] = birthday;
    if (email != null) data['email'] = email;
    return data;
  }
}

// ==================== 用户信息相关 ====================

/// Sa-Token 登录信息
class SaTokenInfo {
  String? tokenName;
  String? tokenValue;
  bool? isLogin;
  dynamic loginId;
  String? loginType;
  int? tokenTimeout;
  int? sessionTimeout;
  int? tokenSessionTimeout;
  int? tokenActiveTimeout;
  String? loginDeviceType;
  String? tag;

  SaTokenInfo({
    this.tokenName,
    this.tokenValue,
    this.isLogin,
    this.loginId,
    this.loginType,
    this.tokenTimeout,
    this.sessionTimeout,
    this.tokenSessionTimeout,
    this.tokenActiveTimeout,
    this.loginDeviceType,
    this.tag,
  });

  SaTokenInfo.fromJson(Map<String, dynamic> json) {
    tokenName = json['tokenName'];
    tokenValue = json['tokenValue'];
    isLogin = json['isLogin'];
    loginId = json['loginId'];
    loginType = json['loginType'];
    // 处理字符串转 int
    tokenTimeout = json['tokenTimeout'] != null
        ? (json['tokenTimeout'] is String
            ? int.tryParse(json['tokenTimeout'])
            : json['tokenTimeout'] as int?)
        : null;
    sessionTimeout = json['sessionTimeout'] != null
        ? (json['sessionTimeout'] is String
            ? int.tryParse(json['sessionTimeout'])
            : json['sessionTimeout'] as int?)
        : null;
    tokenSessionTimeout = json['tokenSessionTimeout'] != null
        ? (json['tokenSessionTimeout'] is String
            ? int.tryParse(json['tokenSessionTimeout'])
            : json['tokenSessionTimeout'] as int?)
        : null;
    tokenActiveTimeout = json['tokenActiveTimeout'] != null
        ? (json['tokenActiveTimeout'] is String
            ? int.tryParse(json['tokenActiveTimeout'])
            : json['tokenActiveTimeout'] as int?)
        : null;
    loginDeviceType = json['loginDeviceType'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tokenName'] = tokenName;
    data['tokenValue'] = tokenValue;
    data['isLogin'] = isLogin;
    data['loginId'] = loginId;
    data['loginType'] = loginType;
    data['tokenTimeout'] = tokenTimeout;
    data['sessionTimeout'] = sessionTimeout;
    data['tokenSessionTimeout'] = tokenSessionTimeout;
    data['tokenActiveTimeout'] = tokenActiveTimeout;
    data['loginDeviceType'] = loginDeviceType;
    data['tag'] = tag;
    return data;
  }
}

/// 用户信息
class UserInfoVO {
  SaTokenInfo? saTokenInfo;
  int? userId;
  String? userName;
  List<String>? roles;
  String? avatar;
  String? nickname;
  String? email;
  String? phone;
  int? sex;
  String? birthday;
  String? signature;

  UserInfoVO({
    this.saTokenInfo,
    this.userId,
    this.userName,
    this.roles,
    this.avatar,
    this.nickname,
    this.email,
    this.phone,
    this.sex,
    this.birthday,
    this.signature,
  });

  UserInfoVO.fromJson(Map<String, dynamic> json) {
    saTokenInfo = json['saTokenInfo'] != null
        ? SaTokenInfo.fromJson(json['saTokenInfo'])
        : null;
    // 处理 userId 字符串转 int
    userId = json['userId'] != null
        ? (json['userId'] is String
            ? int.tryParse(json['userId'])
            : json['userId'] as int?)
        : null;
    userName = json['userName'];
    roles = json['roles']?.cast<String>();
    avatar = json['avatar'];
    nickname = json['nickname'];
    email = json['email'];
    phone = json['phone'];
    // 处理 sex 字符串转 int
    sex = json['sex'] != null
        ? (json['sex'] is String
            ? int.tryParse(json['sex'])
            : json['sex'] as int?)
        : null;
    birthday = json['birthday'];
    signature = json['signature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (saTokenInfo != null) {
      data['saTokenInfo'] = saTokenInfo!.toJson();
    }
    data['userId'] = userId;
    data['userName'] = userName;
    data['roles'] = roles;
    data['avatar'] = avatar;
    data['nickname'] = nickname;
    data['email'] = email;
    data['phone'] = phone;
    data['sex'] = sex;
    data['birthday'] = birthday;
    data['signature'] = signature;
    return data;
  }
}

/// 用户信息响应
class RUserInfoVO {
  int? code;
  String? msg;
  UserInfoVO? data;

  RUserInfoVO({this.code, this.msg, this.data});

  RUserInfoVO.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? UserInfoVO.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  bool get isSuccess => code == 200 || code == 0;
}

/// 字符串响应
class RString {
  int? code;
  String? msg;
  String? data;

  RString({this.code, this.msg, this.data});

  RString.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    data['data'] = data;
    return data;
  }

  bool get isSuccess => code == 200 || code == 0;
}
