class UrlUtil {
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
}
