import 'package:flutter/material.dart';
import 'package:time_tracker_demo/src/presentation/screen/dashboard.dart';

import '../src/presentation/screen/authentication.dart';

class RouteNames {
  static const dashBoard = '/dashBoard';
  static const authen = '/auth';
}

class RouteGenerator {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.authen:
        return MaterialPageRoute(builder: (context) => const AuthenticationScreen());
      case RouteNames.dashBoard:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());
      default:
        return MaterialPageRoute(builder: (context) => const AuthenticationScreen());
    }
  }
}
