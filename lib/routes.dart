import 'package:flutter/material.dart';
import 'package:shangrila/screens/auth_wrapper.dart';
import 'package:shangrila/screens/dashboard_screen.dart';
import 'package:shangrila/screens/timesheet_screen.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const AuthWrapper(),
  '/dashboard': (context) => const DashboardScreen(),
  '/timesheet': (context) => const TimesheetScreen(),
};
