import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jh_debug/jh_debug.dart';
import '../../../../routes/route_name.dart';
import '../../../../constants/themes/index_theme.dart';

import 'components/head_userbox.dart';

class MyPersonal extends StatefulWidget {
  @override
  State<MyPersonal> createState() => _MyPersonalState();
}

class _MyPersonalState extends State<MyPersonal>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsLingo'),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).textTheme.titleLarge?.color ?? Colors.black,
        ),
        toolbarHeight: 44.h, // 与首页保持一致的AppBar高度
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            // 用户信息卡片
            _buildUserInfoCard(),
            SizedBox(height: 20.h),
            // 功能列表
            Expanded(
              child: _buildFunctionList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'myPerBtn1',
        onPressed: () {
          jhDebug.showDebugBtn(); // 全局显示调试按钮
        },
        tooltip: '显示全局浮动调试按钮',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.bug_report,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  // 构建用户信息卡片
  Widget _buildUserInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(24.w),
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
      child: Row(
        children: [
          // 头像
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Icon(
              Icons.person,
              size: 32.w,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(width: 16.w),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '未登录',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '点击登录体验更多功能',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // 登录按钮
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteName.login);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '登录',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建功能列表
  Widget _buildFunctionList() {
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
          _buildListItem(
            icon: Icons.palette,
            title: '主题设置',
            onTap: () {
              Navigator.pushNamed(context, RouteName.themeSettings);
            },
          ),
          _buildDivider(),
          _buildListItem(
            icon: Icons.settings,
            title: '设置',
            onTap: () {
              // TODO: 实现设置功能
            },
          ),
          _buildDivider(),
          _buildListItem(
            icon: Icons.info_outline,
            title: '关于我们',
            onTap: () {
              // TODO: 实现关于我们功能
            },
          ),
        ],
      ),
    );
  }

  // 构建列表项
  Widget _buildListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
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
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20.w,
                color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建分割线
  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 76.w), // 与图标右边对齐
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: Theme.of(context).dividerColor.withOpacity(0.3),
      ),
    );
  }
}
