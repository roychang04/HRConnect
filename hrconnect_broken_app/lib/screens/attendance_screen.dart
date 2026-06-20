import 'package:flutter/material.dart';

import '../data/mock_hr_data.dart';
import '../models/app_user.dart';
import '../models/attendance.dart';
import '../services/employee_service.dart';

class AttendanceScreen extends StatelessWidget {
  final AppUser user;

  const AttendanceScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final employeeService = const EmployeeService();
    final records = mockAttendance.map(Attendance.fromJson).where((record) {
      if (user.isHr) return true;
      return record.employeeId == user.id;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: records.isEmpty
          ? const Center(child: Text('No attendance records found.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                final employee = employeeService.getEmployeeById(record.employeeId);
                return Card(
                  child: ListTile(
                    leading: Icon(
                      record.isLate ? Icons.warning_amber : Icons.check_circle,
                    ),
                    title: Text(employee?.fullName ?? record.employeeId),
                    subtitle: Text(
                      '${record.date.year}-${record.date.month.toString().padLeft(2, '0')}-${record.date.day.toString().padLeft(2, '0')}
'
                      'In: ${record.checkIn} | Out: ${record.checkOut}',
                    ),
                    trailing: Text(record.status),
                  ),
                );
              },
            ),
    );
  }
}
