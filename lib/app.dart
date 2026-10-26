import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/screens/login_screen.dart';

class KazeApp extends StatelessWidget {
  const KazeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Kaze',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: const LoginScreen(),
  );
}
