import 'package:flutter/material.dart';

class LeaveStatusBadge extends StatelessWidget {
  final String status;

  const LeaveStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isApproved = status.toLowerCase() == 'approved';
    final isRejected = status.toLowerCase() == 'rejected';

    final color = isApproved
        ? Colors.green
        : isRejected
            ? Colors.red
            : Colors.orange;

    return Chip(
      label: Text(status),
      backgroundColor: color.withOpacity(0.15),
      side: BorderSide(color: color),
    );
  }
}
