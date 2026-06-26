import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/route_generator.dart';
import 'injection/dependency_injection.dart';
import 'modules/home/view/home_bloc.dart';

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<HomeBloc>(),
          ),
        ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social Assignment',
        onGenerateRoute: RouteGenerator.generate,
        initialRoute: '/',
            ),
      );
  }
}