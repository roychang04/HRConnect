import 'package:flutter/material.dart';

import 'models/app_user.dart';
import 'models/employee.dart';
import 'screens/attendance_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/employee_detail_screen.dart';
import 'screens/employee_list_screen.dart';
import 'screens/leave_application_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const HRConnectApp());
}

class HRConnectApp extends StatelessWidget {
  const HRConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HRConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/dashboard':
            final user = settings.arguments as AppUser;
            return MaterialPageRoute(
              builder: (_) => DashboardScreen(user: user),
            );
          case '/employees':
            final user = settings.arguments as AppUser;
            return MaterialPageRoute(
              builder: (_) => EmployeeListScreen(user: user),
            );
          case '/employee-details':
            final employee = settings.arguments as Employee;
            return MaterialPageRoute(
              builder: (_) => EmployeeDetailScreen(employee: employee),
            );
          case '/leave':
            final user = settings.arguments as AppUser;
            return MaterialPageRoute(
              builder: (_) => LeaveApplicationScreen(user: user),
            );
          case '/attendance':
            final user = settings.arguments as AppUser;
            return MaterialPageRoute(
              builder: (_) => AttendanceScreen(user: user),
            );
          default:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
        }
      },
    );
  }
}
