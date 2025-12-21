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
        title: 'Loading article...',
        summary: 'Loading article content...',
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
        title: const Text('Article Detail'),
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
                            'Image failed to load',
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
                              ? const Color(0xFFFF8A65).withOpacity(0.15)
                              : Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15.r),
                          border: isDarkMode ? Border.all(
                            color: const Color(0xFFFF8A65).withOpacity(0.4),
                            width: 1,
                          ) : null,
                        ),
                        child: Text(
                          article.source,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: isDarkMode
                                ? const Color(0xFFFF8A65)
                                : Theme.of(context).primaryColor,
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
                    'Content Summary',
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
                          label: Text('Share Article'),
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
                          label: const Text('Read Original'),
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
          'Detailed Content',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.titleMedium?.color ?? Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          '''This is a detailed report about ${article.title}. The article deeply explores various aspects of this topic, providing readers with comprehensive information and unique insights.

The article first introduces the background, giving readers a basic understanding of the entire event. Subsequently, the article analyzes key factors in detail, making the argument more persuasive through multiple cases and data support.

Experts believe that this field has broad development prospects and is expected to achieve important breakthroughs in the coming years. At the same time, the article also mentions some current challenges and possible solutions.

Overall, this article presents readers with a comprehensive and in-depth analysis, which is of great significance for understanding the latest developments in this field.''',
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
        content: Text('Share feature coming soon'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // 收藏文章
  void _favoriteArticle() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Favorite feature coming soon'),
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
            content: Text('Unable to open link'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to open link: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
