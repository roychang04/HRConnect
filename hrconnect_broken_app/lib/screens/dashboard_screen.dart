import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../services/employee_service.dart';
import '../widgets/custom_drawer.dart';

class DashboardScreen extends StatelessWidget {
  final AppUser user;

  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final employeeService = const EmployeeService();
    final employees = employeeService.getEmployees();
    final activeEmployees = employees.where((employee) => employee.isActive).length;

    return Scaffold(
      appBar: AppBar(title: const Text('HR Dashboard')),
      drawer: CustomDrawer(user: user),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Welcome, ${user.fullName}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text('Role: ${user.role}'),
          const SizedBox(height: 16),
          _DashboardCard(
            icon: Icons.people,
            title: 'Total Employees',
            value: employees.length.toString(),
          ),
          _DashboardCard(
            icon: Icons.verified_user,
            title: 'Active Employees',
            value: activeEmployees.toString(),
          ),
          _DashboardCard(
            icon: Icons.pending_actions,
            title: 'Pending Leave Requests',
            value: '0',
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/employees', arguments: user);
            },
            icon: const Icon(Icons.people),
            label: const Text('Open Employee Directory'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/leave', arguments: user);
            },
            icon: const Icon(Icons.beach_access),
            label: const Text('Apply Leave'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/attendance', arguments: user);
            },
            icon: const Icon(Icons.access_time),
            label: const Text('View Attendance'),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
