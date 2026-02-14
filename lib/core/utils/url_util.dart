class StrUtil {
  static List<String> parseUrls(String input) {
    // 处理空或 null 输入
    if (input.isEmpty) return [];

    // 按 '#' 分割成多个 "第XX集$url" 片段
    final parts = input.split('#');

    // 对每个片段，按 '$' 分割，取第二部分（URL）
    final urls = <String>[];
    for (final part in parts) {
      final tokens = part.split('\$'); // 注意：\$ 是转义 $ 字符
      if (tokens.length >= 2) {
        urls.add(tokens[1]);
      }
    }

    return urls;
  }

  static String cleanDescription(String input) {
    // 1. 移除所有 HTML 标签（匹配 <...>）
    String withoutTags = input.replaceAll(RegExp(r'<[^>]*>'), '');

    // 2. 替换全角空格（\u3000）、不间断空格（\u00A0）及多个连续空白为单个普通空格
    String normalizedSpaces = withoutTags.replaceAll(
      RegExp(r'[\s\u3000\u00A0]+'),
      ' ',
    );

    // 3. 去除首尾空格
    String trimmed = normalizedSpaces.trim();

    return trimmed;
  }
}
