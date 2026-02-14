import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/widget/error_page.dart';
import 'package:free_play_app/widget/media_card.dart';

class DownloadsPage extends HookWidget {
  static List<Media> downloadedVideos = [];

  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的下载'), centerTitle: true),
      body: downloadedVideos.isEmpty
          ? const ErrorPage()
          : RefreshIndicator(onRefresh: () async {}, child: Text("")),
    );
  }
}
