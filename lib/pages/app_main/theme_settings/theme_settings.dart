import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../provider/theme_store.p.dart';
import '../../../provider/global.p.dart';
import '../../../constants/themes/index_theme.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  late ThemeStore _theme;
  late GlobalStore appPageStore;

  @override
  Widget build(BuildContext context) {
    _theme = Provider.of<ThemeStore>(context, listen: true);
    appPageStore = Provider.of<GlobalStore>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '主题设置',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            // 主题色选择
            _buildSection(
              title: '主题色',
              child: Column(
                children: [
                  _buildThemeOption(
                    title: '天空蓝主题',
                    subtitle: '清新明亮的天空蓝色',
                    color: Colors.lightBlue,
                    isSelected: _theme.getTheme.brightness == Brightness.light,
                    onTap: () => _theme.setTheme(themeLightBlue),
                  ),
                  SizedBox(height: 12.h),
                  _buildThemeOption(
                    title: '暗黑模式',
                    subtitle: '护眼的深色主题',
                    color: Colors.grey[800]!,
                    isSelected: _theme.getTheme.brightness == Brightness.dark,
                    onTap: () => _theme.setTheme(ThemeData.dark()),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            // 特殊功能
            _buildSection(
              title: '特殊功能',
              child: Consumer<GlobalStore>(
                builder: (context, globalStore, child) {
                  return _buildGrayModeOption(globalStore.getGrayTheme);
                },
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 16.h),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleMedium?.color ?? const Color(0xFF333333),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({
    required String title,
    required String subtitle,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color ?? Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Consumer<GlobalStore>(
                  builder: (context, globalStore, child) {
                    return Icon(
                      Icons.check_circle,
                      color: globalStore.getGrayTheme
                          ? Colors.grey[600] // 灰度模式开启时使用灰色
                          : (Theme.of(context).brightness == Brightness.dark
                              ? const Color(0xFFFF8A65) // 暗黑模式使用橙色
                              : Theme.of(context).primaryColor), // 亮色模式使用主题色
                      size: 24.w,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrayModeOption(bool isGrayMode) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          appPageStore.setGrayTheme(!isGrayMode);
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[600] : Colors.grey[400],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[500]! : Colors.grey[600]!,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.filter_b_and_w,
                  color: Colors.white,
                  size: 24.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '灰度模式',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.titleMedium?.color ?? Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '将界面转换为黑白灰度显示',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: isGrayMode,
                onChanged: (value) {
                  appPageStore.setGrayTheme(value);
                },
                activeColor: Colors.grey[600], // 开启时显示灰度颜色
                activeTrackColor: Colors.grey[400], // 开启时轨道显示更浅的灰色
                inactiveThumbColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFFFF8A65) // 暗黑模式关闭时使用橙色
                    : Theme.of(context).primaryColor, // 亮色模式关闭时使用主题色
                inactiveTrackColor: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFFFFB74D) // 暗黑模式关闭时轨道使用更浅的橙色
                    : Theme.of(context).primaryColor.withOpacity(0.3), // 亮色模式关闭时轨道使用半透明主题色
              ),
            ],
          ),
        ),
      ),
    );
  }
}