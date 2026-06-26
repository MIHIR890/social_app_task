import 'package:flutter/material.dart';


import '../../modules/home/view/home_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      //
      // case AppRoutes.profile:
      //   return MaterialPageRoute(
      //     builder: (_) => const ProfilePage(),
      //   );
      //
      // case AppRoutes.search:
      //   return MaterialPageRoute(
      //     builder: (_) => const SearchPage(),
      //   );
      //
      // case AppRoutes.messages:
      //   return MaterialPageRoute(
      //     builder: (_) => const MessagesPage(),
      //   );
      //
      // case AppRoutes.notification:
      //   return MaterialPageRoute(
      //     builder: (_) => const NotificationPage(),
      //   );
      //
      // case AppRoutes.settings:
      //   return MaterialPageRoute(
      //     builder: (_) => const SettingsPage(),
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page Not Found"),
            ),
          ),
        );
    }
  }
}