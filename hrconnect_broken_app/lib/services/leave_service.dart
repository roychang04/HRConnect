import '../models/employee.dart';
import '../models/leave_request.dart';

class LeaveService {
  final List<LeaveRequest> _requests = [];

  List<LeaveRequest> get requests => List.unmodifiable(_requests);

  String submitLeave({
    required Employee employee,
    required LeaveRequest request,
  }) {
    if (request.endDate.isBefore(request.startDate)) {
      throw Exception('End date cannot be before start date.');
    }

    if (request.totalDays > employee.leaveBalance) {//change from request.totalDays > employee.leaveBalance
  throw Exception('Not enough leave balance.');
}

if (request.reason.trim().isEmpty) {
  throw Exception('Reason is required.');
}

// Deduct leave balance
employee.leaveBalance -= request.totalDays;

_requests.add(request);

return 'Leave application submitted successfully. Remaining balance: ${employee.leaveBalance} day(s).';//added employee leave balance in the message
  }
}
