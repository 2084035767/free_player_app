import 'package:flutter/material.dart';

/// 热播类型宫格组件
class PopularCategoriesGrid extends StatelessWidget {
  /// 热播类型列表
  final List<CategoryItem> categories;

  /// 点击回调
  final Function(CategoryItem)? onTap;

  /// 标题
  final String title;

  const PopularCategoriesGrid({
    super.key,
    required this.categories,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 12, // 建议减小间距（64 太大了）
              mainAxisSpacing: 12,
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final category = categories[index];
              return _CategoryGridItem(category: category, onTap: onTap);
            },
            itemCount: categories.length > 8 ? 8 : categories.length,
          ),
        ],
      ),
    );
  }
}

/// 热播类型宫格项
class _CategoryGridItem extends StatelessWidget {
  final CategoryItem category;
  final Function(CategoryItem)? onTap;

  const _CategoryGridItem({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(category),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: .circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: .2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(category.icon, size: 16, color: category.color),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            category.title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// 类型数据模型
class CategoryItem {
  /// 类型标题
  final String title;

  /// 类型图标
  final IconData icon;

  /// 颜色
  final Color color;

  CategoryItem({required this.title, required this.icon, required this.color});
}
