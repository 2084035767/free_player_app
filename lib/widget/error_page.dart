import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 标准错误文本显示组件
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset('assets/json/error.json'));
  }
}
