import 'package:flutter/material.dart';

import 'app.dart';
import 'di/service_locator.dart';

void main() async {
  setupLocator();
  runApp(const MyApp());
}
