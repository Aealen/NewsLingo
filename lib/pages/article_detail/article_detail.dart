import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/article.m.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({super.key, this.params});

  final dynamic params;

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  late ArticleModel article;

  @override
  void initState() {
    super.initState();
    // 从参数中获取文章数据
    if (widget.params is Map && widget.params['article'] != null) {
      article = widget.params['article'];
    } else {
      // 如果没有传入文章数据，使用默认文章
      article = ArticleModel(
        id: 'default',
        title: '文章加载中...',
        summary: '正在加载文章内容...',
        coverImage:
            'https://pic4.zhimg.com/v2-dde84723b58e2d208690c490dc060735_720w.jpg?source=172ae18b',
        source: '未知来源',
        category: '默认类别',
        date: DateTime.now().toString().substring(0, 10),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('文章详情'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.titleLarge?.color,
        iconTheme: IconThemeData(color: Theme.of(context).textTheme.titleLarge?.color),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Theme.of(context).textTheme.titleLarge?.color),
            onPressed: _shareArticle,
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Theme.of(context).textTheme.titleLarge?.color),
            onPressed: _favoriteArticle,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 封面图片
            Stack(
              children: [
                Image.network(
                  article.coverImage,
                  width: double.infinity,
                  height: 250.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250.h,
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 50.w,
                            color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            '图片加载失败',
                            style: TextStyle(
                              color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // 渐变遮罩
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(isDarkMode ? 0.5 : 0.7),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 文章内容
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Text(
                    article.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // 来源和日期
                  Row(
                    children: [
                      // 来源标签
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Theme.of(context).primaryColor.withOpacity(0.2)
                              : Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15.r),
                          border: isDarkMode ? Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            width: 1,
                          ) : null,
                        ),
                        child: Text(
                          article.source,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: isDarkMode
                                ? Theme.of(context).primaryColor.withOpacity(0.8)
                                : Colors.blue[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // 发布日期
                      Text(
                        article.date,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // 摘要标题
                  Text(
                    '内容摘要',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleMedium?.color ?? Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // 摘要内容
                  Text(
                    article.summary,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey[700],
                      height: 1.8,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // 模拟的详细内容
                  _buildContent(),
                  SizedBox(height: 40.h),

                  // 操作按钮
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _shareArticle,
                          icon: Icon(Icons.share, color: Theme.of(context).primaryColor),
                          label: Text('分享文章'),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            side: BorderSide(color: Theme.of(context).primaryColor),
                            foregroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _openOriginal,
                          icon: const Icon(Icons.open_in_browser),
                          label: const Text('阅读原文'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Theme.of(context).colorScheme.onPrimary,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建模拟的详细内容
  Widget _buildContent() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '详细介绍',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleMedium?.color ?? Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          '''这是一篇关于 ${article.title} 的详细报道。文章深入探讨了该主题的各个方面，为读者提供了全面的信息和独到的见解。

文章首先介绍了背景情况，让读者对整个事件有了基本的了解。随后，文章详细分析了关键因素，并通过多个案例和数据支持，使得论述更加具有说服力。

专家表示，这个领域的发展前景广阔，预计在未来几年内将迎来重要突破。同时，文章也提到了当前面临的一些挑战和可能的解决方案。

总的来说，这篇文章为读者呈现了一个全面而深入的分析，对于了解该领域的最新动态具有重要意义。''',
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.grey[700],
            height: 1.8,
          ),
        ),
      ],
    );
  }

  // 分享文章
  void _shareArticle() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('分享功能待完善'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // 收藏文章
  void _favoriteArticle() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('收藏功能待完善'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // 打开原文链接（模拟）
  void _openOriginal() async {
    // 这里模拟打开一个示例网址
    final url = Uri.parse('https://github.com/Aealen');

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('无法打开链接'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('打开链接失败: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
