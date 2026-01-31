import 'package:flutter/material.dart';

/// 顶部导航栏组件
class TopTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// 导航标签列表
  final List<TopTabBarItem> items;

  /// 选中项索引
  final int selectedIndex;

  /// 点击回调
  final Function(int)? onTap;

  /// 是否显示指示器
  final bool showIndicator;

  /// 指示器颜色
  final Color indicatorColor;

  /// 选中文字颜色
  final Color selectedLabelColor;

  /// 未选中文字颜色
  final Color unselectedLabelColor;

  /// 背景颜色
  final Color backgroundColor;

  const TopTabBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onTap,
    this.showIndicator = true,
    this.indicatorColor = Colors.blue,
    this.selectedLabelColor = Colors.blue,
    this.unselectedLabelColor = Colors.grey,
    this.backgroundColor = Colors.white,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: kToolbarHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () => onTap?.call(index),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? selectedLabelColor
                            : unselectedLabelColor,
                      ),
                    ),
                    if (showIndicator && isSelected)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 2,
                        width: 20,
                        color: indicatorColor,
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// 顶部导航栏项
class TopTabBarItem {
  /// 标题
  final String title;

  /// 图标（可选）
  final IconData? icon;

  const TopTabBarItem({required this.title, this.icon});
}
