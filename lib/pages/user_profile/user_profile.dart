import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/auth.m.dart';
import '../../services/auth_service.dart';
import '../../utils/tool/user_util.dart';
import '../../utils/tool/tips_util.dart';
import '../../routes/route_name.dart';
import '../app_main/app_main.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserInfoVO? _userInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  /// 加载用户信息
  Future<void> _loadUserInfo() async {
    setState(() => _isLoading = true);

    try {
      // 先尝试从缓存读取
      UserInfoVO? cachedUserInfo = await UserUtil.getFullUserInfo();

      // 同时请求最新数据
      try {
        RUserInfoVO userInfoRes = await AuthService.getUserInfo();
        if (userInfoRes.isSuccess && userInfoRes.data != null) {
          // 保存到缓存
          await UserUtil.saveFullUserInfo(userInfoRes.data!);
          setState(() {
            _userInfo = userInfoRes.data;
            _isLoading = false;
          });
          return;
        }
      } catch (e) {
        // 请求失败，继续使用缓存数据
      }

      // 使用缓存数据
      if (cachedUserInfo != null) {
        setState(() {
          _userInfo = cachedUserInfo;
          _isLoading = false;
        });
      } else {
        // 没有缓存数据
        setState(() {
          _userInfo = null;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _userInfo = null;
        _isLoading = false;
      });
    }
  }

  /// 退出登录
  Future<void> _logout() async {
    // 显示确认对话框
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('退出登录'),
          content: const Text('确定要退出登录吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                '取消',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                '确定',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      // 先调用退出登录接口（此时 token 还存在）
      try {
        await AuthService.logout();
      } catch (e) {
        // 接口失败也不影响退出流程
        print('退出登录接口失败: $e');
      }

      // 再清除本地认证信息
      await UserUtil.cleanAuth();

      // 延迟显示提示，避免被对话框阻塞
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          try {
            Tips.info('已退出登录');
          } catch (e) {
            // 忽略 Toast 错误
            print('Toast 显示失败: $e');
          }
        }
      });

      // 清空导航栈并跳转到首页
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const AppMain(),
          ),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人信息'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        titleTextStyle: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.titleLarge?.color,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            )
          : _userInfo == null
              ? _buildNotLoggedInView()
              : _buildUserInfoView(),
    );
  }

  /// 未登录视图
  Widget _buildNotLoggedInView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            size: 80.w,
            color: Theme.of(context).disabledColor,
          ),
          SizedBox(height: 16.h),
          Text(
            '未登录',
            style: TextStyle(
              fontSize: 16.sp,
              color: Theme.of(context).disabledColor,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              '去登录',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 用户信息视图
  Widget _buildUserInfoView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 头像区域
                _buildAvatarSection(),
                SizedBox(height: 24.h),

                // 用户信息列表
                _buildInfoSection(),
              ],
            ),
          ),
        ),

        // 底部退出登录按钮
        _buildLogoutButton(),
      ],
    );
  }

  /// 头像区域
  Widget _buildAvatarSection() {
    final String userAvatar = _userInfo?.avatar ?? '';
    final String displayName = _userInfo?.nickname?.isNotEmpty == true
        ? _userInfo!.nickname!
        : (_userInfo?.phone ?? '用户');

    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // 点击头像可以刷新用户信息
              _loadUserInfo();
            },
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(50.r),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: userAvatar.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.network(
                        userAvatar,
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 50.w,
                            color: Theme.of(context).colorScheme.onPrimary,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.person,
                      size: 50.w,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            displayName,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          if (_userInfo?.phone?.isNotEmpty == true)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                _userInfo!.phone!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 用户信息列表
  Widget _buildInfoSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (_userInfo?.userName?.isNotEmpty == true)
            _buildInfoItem(
              icon: Icons.badge,
              label: '用户名',
              value: _userInfo!.userName!,
            ),
          _buildDivider(),
          if (_userInfo?.phone?.isNotEmpty == true)
            _buildInfoItem(
              icon: Icons.phone,
              label: '手机号',
              value: _userInfo!.phone!,
            ),
          _buildDivider(),
          if (_userInfo?.email?.isNotEmpty == true)
            _buildInfoItem(
              icon: Icons.email,
              label: '邮箱',
              value: _userInfo!.email!,
            ),
          _buildDivider(),
          if (_userInfo?.nickname?.isNotEmpty == true)
            _buildInfoItem(
              icon: Icons.person,
              label: '昵称',
              value: _userInfo!.nickname!,
            ),
          _buildDivider(),
          _buildInfoItem(
            icon: Icons.admin_panel_settings,
            label: '角色',
            value: _formatRoles(_userInfo?.roles),
          ),
          if (_userInfo?.signature?.isNotEmpty == true) ...[
            _buildDivider(),
            _buildInfoItem(
              icon: Icons.edit_note,
              label: '个性签名',
              value: _userInfo!.signature!,
            ),
          ],
        ],
      ),
    );
  }

  /// 信息项
  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? const Color(0xFFFF8A65).withOpacity(0.15)
                  : Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              size: 20.w,
              color: isDarkMode
                  ? const Color(0xFFFF8A65)
                  : Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 分割线
  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 76.w),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: Theme.of(context).dividerColor.withOpacity(0.3),
      ),
    );
  }

  /// 退出登录按钮
  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.all(16.w),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _logout,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.1),
          foregroundColor: Theme.of(context).colorScheme.error,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          '退出登录',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 格式化角色列表
  String _formatRoles(List<String>? roles) {
    if (roles == null || roles.isEmpty) {
      return '普通用户';
    }

    // 角色映射
    const Map<String, String> roleMap = {
      'SYS_ADMIN': '系统管理员',
      'ADMIN': '管理员',
      'USER': '普通用户',
    };

    final formattedRoles = roles
        .map((role) => roleMap[role] ?? role)
        .toList();

    if (formattedRoles.length == 1) {
      return formattedRoles.first;
    }

    return formattedRoles.join('、');
  }
}
