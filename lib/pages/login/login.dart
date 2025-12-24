import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/basic_btn/basic_btn.dart';
import 'components/custom_checkbox/custom_checkbox.dart';
import 'components/custom_input/custom_input.dart';
import '../../models/login.m.dart';
import '../../models/auth.m.dart';
import '../../services/auth_service.dart';
import '../../utils/tool/user_util.dart';
import '../../utils/tool/tips_util.dart';
import '../../utils/index.dart';
import '../../routes/route_name.dart';
import '../app_main/app_main.dart';

class Login extends StatefulWidget {
  const Login({super.key, this.params});
  final dynamic params;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode blankNode = FocusNode(); // 响应空白处的焦点的Node
  final double baseTextSize = 32.sp; // 输入框文字
  final double _slaSize = 26.sp; // 协议文字大小
  Color desTextColor = const Color(0xFFB4B9C6);
  final _phoneController = TextEditingController();
  final _captchaController = TextEditingController();
  final _passwordController = TextEditingController();
  Color btnDisableColor = const Color(0xffAFD1FC); // 禁用按钮颜色
  bool isSelected = false; // 协议勾选
  bool _isPasswordLogin = true; // 是否密码登录模式

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _captchaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> initData() async {
    LoginMobileData userInfo = await UserUtil.getUserInfo();
    if (userInfo.mobile?.isNotEmpty ?? false) {
      _phoneController.text = userInfo.mobile!;
    }
  }

  // 是否是手机号
  bool inputIsPhone() {
    if (isPhone(_phoneController.text)) return true;
    Tips.info('请输入正确手机号码');
    return false;
  }

  // 验证码点击
  Future<bool> onTapCaptcha(int value) async {
    if (!inputIsPhone()) return true;
    return false;
  }

  // 登入按钮
  login() async {
    if (!inputIsPhone()) return;
    FocusScope.of(context).requestFocus(blankNode);
    if (!isSelected) return Tips.info('请确认已阅读用户协议和隐私协议');

    try {
      RLoginResVO res;

      if (_isPasswordLogin) {
        // 密码登录
        String pwdText = _passwordController.text;
        if (pwdText.isEmpty) return Tips.info('请输入密码');

        // 调用密码登录接口
        res = await AuthService.doLogin(LoginDTO(
          phone: _phoneController.text,
          password: pwdText,
          encrypted: false, // 前端未加密
        ));
      } else {
        // 验证码登录
        String captText = _captchaController.text;
        if (captText.isEmpty || captText.length < 6) {
          return Tips.info('请输入正确的验证码');
        }

        // 调用验证码登录接口
        res = await AuthService.doLogin(LoginDTO(
          phone: _phoneController.text,
          captcha: captText,
        ));
      }

      // 处理响应
      if (res.isSuccess && res.data != null) {
        // 保存 token
        await UserUtil.saveLoginRes(res.data!);

        // 保存用户信息
        LoginMobileData userData = LoginMobileData(
          mobile: _phoneController.text,
          authorization: res.data!.token,
        );
        await UserUtil.saveUserInfo(userData);

        // 成功后，清空导航栈并跳转到首页
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AppMain(),
            ),
            (route) => false,
          );
          // 跳转后显示提示
          Tips.info('登录成功');
        }
      } else {
        Tips.info(res.msg ?? '登录失败');
      }
    } catch (e) {
      Tips.info('登录请求失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: loginLayout(),
      ),
    );
  }

  Widget loginLayout() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 48.w),
      child: ListView(
        children: [
          navWidget(),
          CustomInput(
            margin: EdgeInsets.only(bottom: 23.w),
            controller: _phoneController,
            autofocus: true,
            hintText: '点击输入手机号码',
            inputType: InputType.close,
          ),
          // 登录方式切换按钮
          _buildLoginTypeSwitch(),
          // 根据登录模式显示不同输入框
          if (_isPasswordLogin)
            CustomInput(
              controller: _passwordController,
              hintText: '请输入密码',
              inputType: InputType.password,
              keyboardType: TextInputType.visiblePassword,
            )
          else
            CustomInput(
              controller: _captchaController,
              hintText: '点击输入短信验证码',
              inputType: InputType.captcha,
              onTapCaptcha: onTapCaptcha,
            ),
          bottomBtn(),
          slaText(),
        ],
      ),
    );
  }

  // 登录方式切换按钮
  Widget _buildLoginTypeSwitch() {
    return Container(
      margin: EdgeInsets.only(bottom: 23.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordLogin = !_isPasswordLogin;
              });
            },
            child: Text(
              _isPasswordLogin ? '验证码登录' : '密码登录',
              style: TextStyle(
                fontSize: 28.sp,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 头部标题
  Widget navWidget() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 128.w),
      child: Column(
        children: [
          Text(
            '登录页面',
            style: TextStyle(fontSize: 64.sp, fontWeight: FontWeight.w600),
          ),
          Text(
            '未注册手机验证后快速登录',
            style: TextStyle(fontSize: 28.sp, color: desTextColor),
          ),
        ],
      ),
    );
  }

  // 底部组件
  Widget bottomBtn() {
    return Container(
      margin: EdgeInsets.only(top: 64.w, bottom: 46.w),
      child: BasicBtn(
        title: '登录 / 注册',
        color: isSelected ? null : btnDisableColor, // 背景
        onPressed: login,
      ),
    );
  }

  // 协议文字
  Widget slaText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: CustomCheckbox(
            value: isSelected,
            onChanged: (value) {
              setState(() {
                isSelected = !value;
              });
            },
            radius: 22,
            size: _slaSize,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              color: const Color(0xFFB4B9C6),
              fontSize: _slaSize,
            ),
            text: '已阅读并接受',
            children: [
              WidgetSpan(
                child: Text(
                  '《用户协议》',
                  style: TextStyle(fontSize: _slaSize),
                ),
              ),
              const TextSpan(text: '和'),
              WidgetSpan(
                child: Text(
                  '《隐私政策》',
                  style: TextStyle(fontSize: _slaSize),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
