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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2196F3) : Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF2196F3) : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.0, // 设置行高为1倍，避免文字偏上
              color: isSelected ? Colors.white : const Color(0xFF666666),
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
              color: const Color(0xFF333333),
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