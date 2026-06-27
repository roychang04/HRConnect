import 'package:flutter/material.dart';

import '../models/app_user.dart';

class CustomDrawer extends StatelessWidget {
  final AppUser user;

  const CustomDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.fullName),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              child: Text(user.fullName.substring(0, 1)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushReplacementNamed(
                context,
                '/dashboard',
                arguments: user,
              );
            },
          ),
          if (user.isHr)
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Employees'),
              onTap: () {
                Navigator.pop(context);

                // CHANGED: '/employees' matches the route registered
                // in main.dart.
                Navigator.pushNamed(
                  context,
                  '/employees',
                  arguments: user,
                );
              },
            ),
          ListTile(
            leading: const Icon(Icons.beach_access),
            title: const Text('Leave Application'),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(
                context,
                '/leave',
                arguments: user,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Attendance'),
            onTap: () {
              Navigator.pop(context);

              Navigator.pushNamed(
                context,
                '/attendance',
                arguments: user,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
