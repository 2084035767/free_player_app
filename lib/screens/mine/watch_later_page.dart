import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/widget/error_page.dart';
import 'package:free_play_app/widget/media_card.dart';

class WatchLaterPage extends HookWidget {
  static List<Media> watchLaterVideos = [];

  const WatchLaterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('稍后观看'), centerTitle: true),
      body: watchLaterVideos.isEmpty
          ? const ErrorPage()
          : RefreshIndicator(onRefresh: () async {}, child: Text("")),
    );
  }
}
