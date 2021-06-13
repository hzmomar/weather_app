import 'package:flutter/material.dart';
import 'package:teleport_air_asia/ui/view/dashboard/dashboard_view.dart';
import 'package:teleport_air_asia/ui/view/splash/splash_view.dart';

class NavRouter {
  static const String initialRoute = '/';
  static const String dashboardRoute = '/dashboardRoute';

  static MaterialPageRoute _pageRoute(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }

  static PageRouteBuilder _slideRoute(Widget page) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final begin = const Offset(0.0, 1.0);
          final end = Offset.zero;
          final curve = Curves.ease;

          final tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return _pageRoute(const SplashView());
      case dashboardRoute:
        return _pageRoute(const DashboardView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
