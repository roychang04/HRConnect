import 'package:flutter/material.dart';

import '../models/app_user.dart';
import '../services/employee_service.dart';
import '../widgets/employee_card.dart';

class EmployeeListScreen extends StatefulWidget {
  final AppUser user;

  const EmployeeListScreen({super.key, required this.user});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final _service = const EmployeeService();
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final employees = _service.searchEmployees(_query);

    return Scaffold(
      appBar: AppBar(title: const Text('Employee Directory')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by name, department, or position',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _query = value;
              },
            ),
          ),
          ListView.builder(
            itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return EmployeeCard(
                  employee: employee,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/employeeDetail',
                      arguments: employee.id,
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}
