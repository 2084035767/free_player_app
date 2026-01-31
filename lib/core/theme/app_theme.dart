import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 应用主题管理类
class AppThemes {
  // 私有构造函数，防止实例化
  AppThemes._();

  // 主要颜色定义 - 初音莫奈配色方案 (用户指定配色)
  static const Color primaryGray = Color(0xFF60B49D); // 主要初音色
  static const Color lightGray = Color(0xFFDCEFEA); // 很浅的绿色背景
  static const Color mediumGray = Color(0xFFA5D5C8); // 浅绿色
  static const Color darkGray = Color(0xFF387665); // 中等绿色
  static const Color backgroundColor = Color(0xFFFBFCFD);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color accentGreen = Color(0xFF60B49D); // 主要初音色

  // 初音莫奈配色方案 - 以初音色为基础的和谐色彩
  static const Color accentBlue = Color(0xFF60A1B4); // 蓝色调
  static const Color accentRed = Color(0xFF387665); // 深绿色替代红色
  static const Color accentYellow = Color(0xFFA5D5C8); // 浅绿色替代黄色
  static const Color accentPurple = Color(0xFF60B4B2); // 青色调
  static const Color accentTeal = Color(0xFF60B488); // 绿青色调
  static const Color accentOrange = Color(0xFF60B473); // 绿色调

  // 统一文字颜色 - 用户要求
  static const Color primaryTextColor = Color(0xFF17312A); // 浅色模式主字体
  static const Color secondaryTextColor = Color(0xFF387665); // 浅色模式小字/注释
  static const Color darkPrimaryTextColor = Color(0xFFDCEFEA); // 深色模式主字体
  static const Color darkSecondaryTextColor = Color(0xFFA5D5C8); // 深色模式小字/注释

  // 性冷淡风格的辅助颜色
  static const Color coolGray50 = Color(0xFFF8FAFC);
  static const Color coolGray100 = Color(0xFFF1F5F9);
  static const Color coolGray200 = Color(0xFFE2E8F0);
  static const Color coolGray300 = Color(0xFFCBD5E1);
  static const Color coolGray400 = Color(0xFF94A3B8);
  static const Color coolGray500 = Color(0xFF64748B);
  static const Color coolGray600 = Color(0xFF475569);
  static const Color coolGray700 = Color(0xFF334155);
  static const Color coolGray800 = Color(0xFF1E293B);
  static const Color coolGray900 = Color(0xFF0F172A);

  // 深色主题颜色 - 恢复原背景色
  static const Color darkBackgroundColor = Color(0xFF0F172A); // 恢复原深色背景
  static const Color darkCardColor = Color(0xFF1E293B); // 恢复原卡片颜色
  static const Color darkPrimaryGray = Color(0xFF60B49D); // 主要初音色
  static const Color darkAccentGreen = Color(0xFFA5D5C8); // 浅绿色

  // 深色模式初音莫奈配色
  static const Color darkAccentBlue = Color(0xFF60A1B4); // 蓝色调
  static const Color darkAccentRed = Color(0xFF60B473); // 绿色调替代红色
  static const Color darkAccentYellow = Color(0xFFDCEFEA); // 很浅绿色替代黄色
  static const Color darkAccentOrange = Color(0xFF60B488); // 绿青色调

  /// 便捷的颜色获取方法 - 根据主题自动选择合适的颜色

  /// 获取主标题颜色（重要内容）
  /// 浅色模式：使用原有颜色，深色模式：#DCEFEA
  static Color getPrimaryTitleColor(BuildContext context, {Color? lightColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFDCEFEA) : (lightColor ?? primaryGray);
  }

  /// 获取副标题颜色（次要内容、标签）
  /// 浅色模式：使用原有颜色，深色模式：#A5D5C8
  static Color getSecondaryTitleColor(
    BuildContext context, {
    Color? lightColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFA5D5C8) : (lightColor ?? coolGray600);
  }

  /// 获取主要文本颜色（单词名称、定义等重要文本）
  static Color getPrimaryTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFDCEFEA) : primaryTextColor;
  }

  /// 获取次要文本颜色（标签、说明文字等）
  static Color getSecondaryTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFA5D5C8) : secondaryTextColor;
  }

  /// 获取卡片背景颜色
  static Color getCardColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkCardColor : cardColor;
  }

  /// 亮色主题
  static ThemeData get lightTheme => _buildLightTheme();

  /// 暗色主题
  static ThemeData get darkTheme => _buildDarkTheme();

  /// 构建亮色主题
  static ThemeData _buildLightTheme() {
    final base = ThemeData.light();
    return base.copyWith(
      // primarySwatch: Colors.blueGrey,
      primaryColor: primaryGray,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor.withValues(alpha: .8), // 亚克力效果 - 半透明
        foregroundColor: coolGray700,
        elevation: 0,
        scrolledUnderElevation: 8, // 滚动时的阴影
        surfaceTintColor: backgroundColor.withValues(alpha: .1), // 滚动时的着色
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 16, // 从18减少到16
          fontWeight: FontWeight.w600,
          color: coolGray700,
        ),
        // 亚克力模糊效果需要在具体使用时通过BackdropFilter实现
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0.5, // 减少阴影
        shadowColor: Colors.black.withValues(alpha: 0.06), // 减少阴影透明度
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)), // 减少圆角
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(Colors.grey.shade100),
        elevation: WidgetStateProperty.all(0.5),
        constraints: BoxConstraints(
          minHeight: 48, // 保证最小点击区域（符合无障碍标准）
          maxHeight: 60,
        ),
        shadowColor: WidgetStateProperty.all(
          Colors.black.withValues(alpha: .06),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24, // 从32减少到24
          fontWeight: FontWeight.w700,
          color: coolGray800,
          letterSpacing: 0.3, // 减少字间距
        ),
        headlineMedium: TextStyle(
          fontSize: 20, // 从24减少到20
          fontWeight: FontWeight.w600,
          color: coolGray700,
          letterSpacing: 0.2, // 减少字间距
        ),
        titleLarge: TextStyle(
          fontSize: 18, // 从20减少到18
          fontWeight: FontWeight.w500,
          color: coolGray600,
        ),
        titleMedium: TextStyle(
          fontSize: 16, // 从20减少到18
          fontWeight: FontWeight.w500,
          color: coolGray600,
        ),
        bodyLarge: TextStyle(
          fontSize: 14, // 从16减少到14
          color: coolGray700,
          height: 1.4, // 减少行高
        ),
        bodyMedium: TextStyle(
          fontSize: 13, // 从14减少到13
          color: coolGray500,
          height: 1.3, // 减少行高
        ),
        labelLarge: TextStyle(
          fontSize: 11, // 从12减少到11
          color: coolGray400,
          fontWeight: FontWeight.w500,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: coolGray400,
          foregroundColor: Colors.white,
          elevation: 0.5, // 减少阴影
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ), // 减少padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 减少圆角
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: backgroundColor.withValues(alpha: .8), // 亚克力效果 - 半透明
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: coolGray50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ), // 减少内边距
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // 减少圆角
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // 减少圆角
          borderSide: BorderSide(color: coolGray300, width: 1),
        ),
      ),

      // 添加ListTile主题，减少列表项高度
      listTileTheme: ListTileThemeData(
        minTileHeight: 48.0,
        horizontalTitleGap: 12.0,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ), // 减少内边距
        minVerticalPadding: 4, // 减少最小垂直间距
        dense: true, // 启用紧凑模式
      ),

      // 添加Icon主题，减少图标大小
      iconTheme: IconThemeData(
        size: 20, // 减少默认图标大小
        color: coolGray500,
      ),

      // 添加Chip主题
      chipTheme: ChipThemeData(
        elevation: 0.5,
        side: BorderSide.none,
        color: WidgetStateProperty.all(coolGray200),
        shadowColor: Colors.black.withValues(alpha: 0.06),
        backgroundColor: coolGray100,
        labelStyle: TextStyle(fontSize: 12, color: coolGray700),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  /// 构建暗色主题
  static ThemeData _buildDarkTheme() {
    final base = ThemeData.dark();
    return base.copyWith(
      // primarySwatch: Colors.blueGrey,
      primaryColor: darkPrimaryGray,
      scaffoldBackgroundColor: darkBackgroundColor,
      brightness: Brightness.dark,
      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(darkCardColor),
        elevation: WidgetStateProperty.all(0.5),
        constraints: BoxConstraints(
          minHeight: 48, // 保证最小点击区域（符合无障碍标准）
          maxHeight: 60,
        ),
        shadowColor: WidgetStateProperty.all(
          Colors.black.withValues(alpha: .06),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardThemeData(
        color: darkCardColor,
        elevation: 0.5,
        shadowColor: Colors.black.withValues(alpha: .2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: coolGray100,
          letterSpacing: 0.3,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: coolGray200,
          letterSpacing: 0.2,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: coolGray300,
        ),
        bodyLarge: TextStyle(fontSize: 14, color: coolGray200, height: 1.4),
        bodyMedium: TextStyle(fontSize: 13, color: coolGray400, height: 1.3),
        labelLarge: TextStyle(
          fontSize: 11,
          color: coolGray500,
          fontWeight: FontWeight.w500,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: darkBackgroundColor.withValues(
          alpha: .8,
        ), // 亚克力效果 - 半透明
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: coolGray600,
          foregroundColor: Colors.white,
          elevation: 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: coolGray800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: coolGray600, width: 1),
        ),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: darkBackgroundColor.withValues(
          alpha: .8,
        ), // 亚克力效果 - 半透明
        foregroundColor: coolGray200,
        elevation: 0,
        scrolledUnderElevation: 8, // 滚动时的阴影
        surfaceTintColor: darkCardColor.withValues(alpha: .3), // 滚动时的着色
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: coolGray200,
        ),
        // 亚克力模糊效果需要在具体使用时通过BackdropFilter实现
      ),

      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minVerticalPadding: 4,
        dense: true,
        textColor: coolGray200,
        iconColor: coolGray400,
      ),

      iconTheme: IconThemeData(size: 20, color: coolGray400),

      chipTheme: ChipThemeData(
        elevation: 0.5,
        side: BorderSide.none,
        color: WidgetStateProperty.all(coolGray400),
        shadowColor: Colors.black.withValues(alpha: 0.06),
        backgroundColor: coolGray700,
        labelStyle: TextStyle(fontSize: 12, color: coolGray200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
