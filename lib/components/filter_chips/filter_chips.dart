import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const FilterChipWidget({
    Key? key,
    required this.label,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? const Color(0xFFFF8A65) : Theme.of(context).primaryColor) // 暗黑模式使用橙色，亮色模式使用主题色
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected
                ? (isDarkMode ? const Color(0xFFFF8A65) : Theme.of(context).primaryColor)
                : Theme.of(context).dividerColor,
            width: 1,
          ),
          boxShadow: isSelected && isDarkMode ? [
            BoxShadow(
              color: const Color(0xFFFF8A65).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.0, // 设置行高为1倍，避免文字偏上
              color: isSelected
                  ? (isDarkMode ? Colors.white : Theme.of(context).colorScheme.onPrimary) // 暗黑模式橙色背景用白色文字，确保可读性
                  : Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF666666),
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterSection extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final Function(String?) onSelected;

  const FilterSection({
    Key? key,
    required this.title,
    required this.options,
    this.selectedOption,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.titleMedium?.color ?? const Color(0xFF333333),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 44.h, // 与搜索框高度一致
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: options.length + 1, // +1 for "全部" option
            itemBuilder: (context, index) {
              if (index == 0) {
                // "全部" 选项
                return Container(
                  margin: EdgeInsets.only(right: 8.w),
                  child: FilterChipWidget(
                    label: '全部',
                    isSelected: selectedOption == null,
                    onTap: () => onSelected(null),
                  ),
                );
              }

              final option = options[index - 1];
              return Container(
                margin: EdgeInsets.only(right: 8.w),
                child: FilterChipWidget(
                  label: option,
                  isSelected: selectedOption == option,
                  onTap: () => onSelected(option),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}