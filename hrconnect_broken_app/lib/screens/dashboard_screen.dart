import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../models/employee.dart';
import '../services/employee_service.dart';
import '../widgets/custom_drawer.dart';

class DashboardScreen extends StatelessWidget {
  final AppUser user;

  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final employeeService = const EmployeeService();
    final employees = employeeService.getEmployees();

    final activeEmployees =
        employees.where((employee) => employee.isActive).length;

    // added: retrieves the logged-in user's employee record.
    final employee = employeeService.getEmployeeById(user.employeeId);

    // added: keeps role-based conditions readable throughout this screen.
    final isHr = user.isHr;

    return Scaffold(
      appBar: AppBar(
        // CHANGED: employees now receive a personal dashboard title
        // instead of an HR-only title.
        title: Text(isHr ? 'HR Dashboard' : 'My Dashboard'),
      ),
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

          // CHANGED: HR users see organisation-wide management information.
          if (isHr) ...[
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
            const _DashboardCard(
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
              label: const Text('View All Attendance'),
            ),
          ] else ...[
            // added: employees see only their own information,
            // not company-wide HR statistics.
            _EmployeeDashboardContent(employee: employee),
            const SizedBox(height: 16),
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
              label: const Text('View My Attendance'),
            ),
          ],
        ],
      ),
    );
  }
}

// added: keeps employee-only dashboard information separate
// from HR management cards.
class _EmployeeDashboardContent extends StatelessWidget {
  final Employee? employee;

  const _EmployeeDashboardContent({required this.employee});

  @override
  Widget build(BuildContext context) {
    if (employee == null) {
      return const _DashboardCard(
        icon: Icons.error_outline,
        title: 'Employee Profile',
        value: 'Unavailable',
      );
    }

    return Column(
      children: [
        _DashboardCard(
          icon: Icons.calendar_month,
          title: 'My Leave Balance',
          value: '${employee!.leaveBalance} days',
        ),
        _DashboardCard(
          icon: employee!.isActive
              ? Icons.verified_user
              : Icons.person_off,
          title: 'Employment Status',
          value: employee!.isActive ? 'Active' : 'Inactive',
        ),
        _DashboardCard(
          icon: Icons.business,
          title: 'My Department',
          value: employee!.department,
        ),
        _DashboardCard(
          icon: Icons.badge,
          title: 'My Position',
          value: employee!.position,
        ),
      ],
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
