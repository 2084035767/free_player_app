import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/widget/error_page.dart';
import 'package:free_play_app/widget/media_card.dart';

class HistoryPage extends HookWidget {
  static List<Media> historyVideos = [];

  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('观看历史'), centerTitle: true),
      body: historyVideos.isEmpty
          ? const ErrorPage()
          : RefreshIndicator(onRefresh: () async {}, child: Text("")),
    );
  }
}
