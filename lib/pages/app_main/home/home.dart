import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../components/update_app/check_app_version.dart';
import '../../../components/article_item/article_item.dart';
import '../../../components/filter_chips/filter_chips.dart';
import '../../../routes/route_name.dart';
import '../../../config/app_env.dart' show appEnv;
import '../../../models/article.m.dart';
import 'provider/counterStore.p.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.params});
  final dynamic params;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late CounterStore _counter;
  FocusNode blankNode = FocusNode(); // 响应空白处的焦点的Node
  List<ArticleModel> articles = []; // 文章列表
  List<ArticleModel> filteredArticles = []; // 筛选后的文章列表
  TextEditingController _searchController = TextEditingController(); // 搜索控制器
  String? selectedCategory; // 选中的领域/类别
  String? selectedSource; // 选中的来源

  @override
  void initState() {
    super.initState();
    // 初始化文章数据
    articles = ArticleModel.getMockData();
    filteredArticles = articles;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 搜索筛选文章
  void _filterArticles() {
    setState(() {
      filteredArticles = articles.where((article) {
        // 搜索条件
        bool matchesSearch = _searchController.text.isEmpty ||
            article.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            article.summary.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            article.source.toLowerCase().contains(_searchController.text.toLowerCase());

        // 领域筛选
        bool matchesCategory = selectedCategory == null || article.category == selectedCategory;

        // 来源筛选
        bool matchesSource = selectedSource == null || article.source == selectedSource;

        return matchesSearch && matchesCategory && matchesSource;
      }).toList();
    });
  }

  // 获取所有可用的领域列表
  List<String> getAvailableCategories() {
    final categories = articles.map((article) => article.category).toSet().toList();
    categories.sort();
    return categories;
  }

  // 获取所有可用的来源列表
  List<String> getAvailableSources() {
    final sources = articles.map((article) => article.source).toSet().toList();
    sources.sort();
    return sources;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _counter = Provider.of<CounterStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('NewsLingo'),
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleTextStyle: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        toolbarHeight: 44.h, // 自定义AppBar高度
      ),
      backgroundColor: const Color(0xFFF5F6FA),
      body: GestureDetector(
        onTap: () {
          // 点击空白页面关闭键盘
          FocusScope.of(context).requestFocus(blankNode);
        },
        child: Column(
          children: [
            // 搜索框区域
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: StatefulBuilder(
                builder: (context, setInnerState) {
                  return SizedBox(
                    height: 48.h, // 增加搜索框实际高度
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _filterArticles();
                        setInnerState(() {});
                      },
                      style: TextStyle(
                        fontSize: 15.sp,
                        height: 1.2, // 控制光标高度
                      ),
                      cursorHeight: 22.h, // 增加光标高度
                      decoration: InputDecoration(
                        hintText: '搜索文章标题、摘要或来源...',
                        hintStyle: TextStyle(
                          color: const Color(0xFF999999),
                          fontSize: 15.sp,
                          height: 1.2, // 控制提示文字高度
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: const Color(0xFF999999),
                          size: 22.w,
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 44.w,
                          minHeight: 22.h,
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: const Color(0xFF999999),
                                  size: 20.w,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterArticles();
                                  setInnerState(() {});
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              )
                            : null,
                        filled: true,
                        fillColor: const Color(0xFFF8F9FA),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h, // 增加垂直padding
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide(
                            color: const Color(0xFF2196F3),
                            width: 2,
                          ),
                        ),
                        isDense: false, // 允许正常的内边距
                      ),
                    ),
                  );
                },
              ),
            ),
            // 筛选条件区域
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                children: [
                  // 领域筛选
                  FilterSection(
                    title: '领域',
                    options: getAvailableCategories(),
                    selectedOption: selectedCategory,
                    onSelected: (category) {
                      setState(() {
                        selectedCategory = category;
                        _filterArticles();
                      });
                    },
                  ),
                  // 来源筛选
                  FilterSection(
                    title: '来源',
                    options: getAvailableSources(),
                    selectedOption: selectedSource,
                    onSelected: (source) {
                      setState(() {
                        selectedSource = source;
                        _filterArticles();
                      });
                    },
                  ),
                ],
              ),
            ),
            // 文章列表区域
            Expanded(
              child: contextWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget contextWidget() {
    // 如果没有搜索结果，显示提示
    if (filteredArticles.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64.w,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16.h),
            Text(
              '没有找到相关文章',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '请尝试其他关键词',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: filteredArticles.length,
      itemBuilder: (context, index) {
        final article = filteredArticles[index];
        return ArticleItem(
          article: article,
          onTap: () {
            // 跳转到文章详情页
            Navigator.pushNamed(
              context,
              RouteName.articleDetail,
              arguments: {'article': article},
            );
          },
        );
      },
    );
  }

  Widget _button(String text, {VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 22.sp),
        ),
      ),
    );
  }
}
