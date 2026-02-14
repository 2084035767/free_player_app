import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals_hooks/signals_hooks.dart';

class ExpandableText extends HookWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 2,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = useSignal<bool>(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          maxLines: expanded.value ? null : maxLines,
          overflow: expanded.value ? null : TextOverflow.ellipsis,
          style: style,
        ),
        if (text.length > 50)
          Align(
            alignment: Alignment.centerRight, // 水平右对齐
            child: TextButton(
              onPressed: () {
                expanded.value = !expanded.value;
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                expanded.value ? '收起' : '更多',
                style: const TextStyle(
                  color: Color.fromARGB(255, 77, 152, 213),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
