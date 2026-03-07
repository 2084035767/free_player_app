import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fox_player/core/local/prefs.dart';
import 'package:fox_player/services/device_user_manager.dart';

import 'app.dart';
import 'di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Prefs.init();
  await DeviceUserManager.instance.init();
  // await DeviceUserManager.instance.clearUser();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}
