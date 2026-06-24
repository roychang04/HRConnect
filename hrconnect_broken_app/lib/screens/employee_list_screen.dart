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

    // Search box at the top
    Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Search by name, department, or position',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),

        // CHANGED:
        // setState() tells Flutter to rebuild the screen
        // whenever the search text changes.
        // Without setState(), _query changes but the UI
        // never refreshes.
        onChanged: (value) {
          setState(() {
            _query = value;
          });
        },
      ),
    ),

    // CHANGED:
    // Expanded gives ListView the remaining available space.
    // Without Expanded, ListView inside Column has no height,
    // causing the page to appear empty.
    Expanded(
      child: ListView.builder(

        // Number of employees to display
        itemCount: employees.length,

        itemBuilder: (context, index) {

          // Get employee at current index
          final employee = employees[index];

          return EmployeeCard(
            employee: employee,

            onTap: () {

              // CHANGED:
              // Route name must match the route defined
              // in main.dart.
              //
              // WRONG:
              // '/employeeDetail'
              //
              // CORRECT:
              // '/employee-details'
              Navigator.pushNamed(
                context,
                '/employee-details',

                // CHANGED:
                // EmployeeDetailScreen expects an Employee object.
                //
                // WRONG:
                // arguments: employee.id
                //
                // CORRECT:
                // arguments: employee
                arguments: employee,
              );
            },
          );
        },
      ),
    ),
  ],
),
    );
  }
}
