import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../routes/route_name.dart';

class HeadUserBox extends StatefulWidget {
  @override
  State<HeadUserBox> createState() => _HeadUserBoxState();
}

class _HeadUserBoxState extends State<HeadUserBox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 登录/注册按钮
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            btnWidget(
              title: "登入/注册",
              onTap: () {
                Navigator.pushNamed(context, RouteName.login);
              },
            ),
          ],
        ),
        // 主题设置按钮
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            themeSettingBtnWidget(
              title: "主题设置",
              onTap: () {
                Navigator.pushNamed(context, RouteName.themeSettings);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget baseBox({Widget? child}) {
    const double interval = 20;
    return Container(
      alignment: Alignment.center,
      height: 130,
      margin: const EdgeInsets.fromLTRB(interval, 0, interval, 0),
      child: child,
    );
  }

  Widget btnWidget({required String title, VoidCallback? onTap}) {
    return baseBox(
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(fontSize: 33.sp),
        ),
      ),
    );
  }

  Widget themeSettingBtnWidget({required String title, VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 80.h,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          Icons.palette,
          size: 24.w,
          color: Colors.white,
        ),
        label: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
