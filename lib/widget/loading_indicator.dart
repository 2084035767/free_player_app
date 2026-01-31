import 'package:flutter/material.dart';

/// 标准加载指示器组件
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 24.0});

  /// 指示器大小
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}