import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:free_play_app/widget/error_page.dart';
import 'package:free_play_app/widget/media_card.dart';

class FavoritesPage extends HookWidget {
  static List<Media> favoriteVideos = [];

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的收藏'), centerTitle: true),
      body: favoriteVideos.isEmpty ? const ErrorPage() : Text(""),
    );
  }
}
