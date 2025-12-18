import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/article.m.dart';

class ArticleItem extends StatelessWidget {
  final ArticleModel article;
  final VoidCallback? onTap;

  const ArticleItem({
    super.key,
    required this.article,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.15),
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.08),
        child: Container(
          padding: EdgeInsets.all(20.w),
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            // 玻璃拟态效果
            color: isDarkMode
                ? Colors.white.withOpacity(0.05) // 暗黑模式下半透明白色
                : Theme.of(context).cardColor, // 亮色模式下使用主题卡片色
            borderRadius: BorderRadius.circular(12.r),
            border: isDarkMode
                ? Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  )
                : null,
            boxShadow: [
              // 玻璃拟态阴影效果
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.04),
                blurRadius: isDarkMode ? 20 : 10,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.2)
                    : Colors.black.withOpacity(0.02),
                blurRadius: isDarkMode ? 40 : 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左侧内容区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 文章标题 - 最大字体
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color ?? (isDarkMode ? Colors.white : const Color(0xFF1A1A1A)),
                      height: 1.4,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),

                  // 文章摘要 - 较小字体，颜色较淡
                  Text(
                    article.summary,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color ?? (isDarkMode ? Colors.white70 : const Color(0xFF666666)),
                      height: 1.6,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),

                  // 来源标签和日期行
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // 来源标签
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Theme.of(context).primaryColor.withOpacity(0.2)
                              : const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(16.r),
                          border: isDarkMode
                              ? Border.all(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Text(
                          article.source,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: isDarkMode
                                ? Theme.of(context).primaryColor.withOpacity(0.8)
                                : const Color(0xFF1976D2),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // 日期
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14.w,
                            color: Theme.of(context).textTheme.bodySmall?.color ?? (isDarkMode ? Colors.white60 : const Color(0xFF999999)),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            article.date,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Theme.of(context).textTheme.bodySmall?.color ?? (isDarkMode ? Colors.white60 : const Color(0xFF999999)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 16.w),

            // 右侧封面图
            Container(
              width: 110.w,
              height: 85.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.08),
                    blurRadius: isDarkMode ? 10 : 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  article.coverImage,
                  width: 110.w,
                  height: 85.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 110.w,
                      height: 85.h,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.white.withOpacity(0.03)
                            : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8.r),
                        border: isDarkMode
                            ? Border.all(
                                color: Colors.white.withOpacity(0.05),
                                width: 1,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image_outlined,
                            color: isDarkMode
                                ? Colors.white.withOpacity(0.2)
                                : const Color(0xFFBDBDBD),
                            size: 28.w,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '暂无图片',
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.white.withOpacity(0.3)
                                  : const Color(0xFFBDBDBD),
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}