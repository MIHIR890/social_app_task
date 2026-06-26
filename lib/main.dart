import 'package:flutter/material.dart';

import 'app.dart';
import 'injection/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(
    const SocialApp(),
  );
}