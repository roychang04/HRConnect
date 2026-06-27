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

    final records = mockAttendance
        .map((e) {
          try {
            return Attendance.fromJson(e);
          } catch (_) {
            return null;
          }
        })
        .whereType<Attendance>()
        .where((record) {
          if (user.isHr) {
            return true;
          }

          // CHANGED: attendance records use employee IDs
          // (for example, E002), not user IDs (for example, U002).
          return record.employeeId == user.employeeId;
        })
        .toList();

    return Scaffold(
      // CHANGED: the title now clarifies whether the user is viewing
      // all records or only their own.
      appBar: AppBar(
        title: Text(
          user.isHr ? 'Attendance Records' : 'My Attendance',
        ),
      ),
      body: records.isEmpty
          ? const Center(
              child: Text('No attendance records found.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];

                final employee =
                    employeeService.getEmployeeById(record.employeeId);

                return Card(
                  child: ListTile(
                    leading: Icon(
                      record.isNull
                          ? Icons.question_mark
                          : record.isLate
                              ? Icons.warning_amber
                              : record.isAbsent
                                  ? Icons.disabled_by_default
                                  : Icons.check_circle,
                    ),
                    title: Text(employee?.fullName ?? record.employeeId),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.date == null
                              ? 'Date: -'
                              : 'Date: '
                                  '${record.date!.year}-'
                                  '${record.date!.month.toString().padLeft(2, '0')}-'
                                  '${record.date!.day.toString().padLeft(2, '0')}',
                        ),
                        Text('In: ${record.checkIn}'),
                        Text('Out: ${record.checkOut}'),
                      ],
                    ),
                    trailing: Text(
                      record.status,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
