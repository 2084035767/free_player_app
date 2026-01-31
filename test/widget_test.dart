// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:free_play_app/app.dart';
import 'package:free_play_app/di/service_locator.dart';
import 'package:free_play_app/models/video.dart';
import 'package:free_play_app/services/auth_service.dart';
import 'package:free_play_app/services/video_service.dart';
import 'package:free_play_app/viewmodels/auth_view_model.dart';
import 'package:free_play_app/viewmodels/video_view_model.dart';

class FakeVideoService extends VideoService {
  FakeVideoService() : super(Dio());

  @override
  Future<List<Video>> fetchHomeVideos() async => [];

  @override
  Future<Video> fetchDetail(int id) async {
    return Video(
      vodId: id,
      vodName: '',
      typeId: 0,
      typeName: '',
      vodPic: '',
      vodClass: '',
      vodActor: '',
      vodDirector: '',
      vodBlurb: '',
      vodTime: '',
      vodArea: '',
      vodDoubanScore: '',
      vodYear: '',
      vodRemarks: '',
      vodPlayFrom: '',
      vodPlayUrl: '',
      vodDuration: '',
    );
  }

  @override
  Future<List<Video>> fetchCategory(int t) async => [];
}

void main() {
  setUpAll(() async {
    await getIt.reset();
    getIt.registerLazySingleton<AuthService>(() => AuthService(Dio()));
    getIt.registerFactory(() => AuthViewModel(getIt()));
    getIt.registerLazySingleton<VideoService>(() => FakeVideoService());
    getIt.registerFactory(() => VideoViewModel(getIt()));
  });

  testWidgets('App renders home navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('主页'), findsWidgets);
    expect(find.text('发现'), findsWidgets);
    expect(find.text('分类'), findsWidgets);
    expect(find.text('个人'), findsWidgets);
  });
}
