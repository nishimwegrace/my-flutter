import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFAF8F4),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFFAF8F4),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const KazeApp());
}
