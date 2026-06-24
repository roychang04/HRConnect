import 'package:flutter/material.dart';

import '../models/employee.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(employee.fullName)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 42,
            child: Text(
              employee.fullName.substring(0, 1),
              style: const TextStyle(fontSize: 32),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            employee.fullName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            employee.position,
            textAlign: TextAlign.center,
          ),
          const Divider(height: 32),
          _InfoTile(label: 'Staff ID', value: employee.id),
          _InfoTile(label: 'Department', value: employee.department),
          _InfoTile(label: 'Email', value: employee.email),
          _InfoTile(label: 'Phone', value: employee.phone),//change employee.email to employee.phone
          _InfoTile(label: 'Manager', value: employee.managerName),
          _InfoTile(label: 'Leave Balance', value: '${employee.leaveBalance} days'),
          _InfoTile(label: 'Status', value: employee.isActive ? 'Active' : 'Inactive'),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
      ),
    );
  }
}
