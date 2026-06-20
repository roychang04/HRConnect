import 'package:flutter/material.dart';

import '../data/mock_hr_data.dart';
import '../models/app_user.dart';
import '../models/leave_request.dart';
import '../services/employee_service.dart';
import '../services/leave_service.dart';

class LeaveApplicationScreen extends StatefulWidget {
  final AppUser user;

  const LeaveApplicationScreen({super.key, required this.user});

  @override
  State<LeaveApplicationScreen> createState() => _LeaveApplicationScreenState();
}

class _LeaveApplicationScreenState extends State<LeaveApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _employeeService = const EmployeeService();
  final _leaveService = LeaveService();

  String? _selectedLeaveType;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2026, 6, 15),
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2026, 12, 31),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime(2026, 6, 15),
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2026, 12, 31),
    );
    if (picked != null) {
      setState(() => _startDate = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedLeaveType == null || _startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete leave type and dates.')),
      );
      return;
    }

    final employee = _employeeService.getEmployeeById(widget.user.employeeId);
    if (employee == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Employee record not found.')),
      );
      return;
    }

    final request = LeaveRequest(
      employeeId: employee.id,
      leaveType: _selectedLeaveType!,
      startDate: _startDate!,
      endDate: _endDate!,
      reason: _reasonController.text,
    );

    try {
      final message = _leaveService.submitLeave(
        employee: employee,
        request: request,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      setState(() {
        _selectedLeaveType = null;
        _startDate = null;
        _endDate = null;
        _reasonController.clear();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString().replaceFirst('Exception: ', ''))),
      );
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Not selected';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final employee = _employeeService.getEmployeeById(widget.user.employeeId);

    return Scaffold(
      appBar: AppBar(title: const Text('Leave Application')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (employee != null)
              Card(
                child: ListTile(
                  title: Text(employee.fullName),
                  subtitle: Text('Leave balance: ${employee.leaveBalance} days'),
                ),
              ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedLeaveType,
              decoration: const InputDecoration(
                labelText: 'Leave Type',
                border: OutlineInputBorder(),
              ),
              items: leaveTypes
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedLeaveType = value);
              },
              validator: (value) => value == null ? 'Please select leave type.' : null,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickStartDate,
              icon: const Icon(Icons.calendar_today),
              label: Text('Start Date: ${_formatDate(_startDate)}'),
            ),
            OutlinedButton.icon(
              onPressed: _pickEndDate,
              icon: const Icon(Icons.calendar_today),
              label: Text('End Date: ${_formatDate(_endDate)}'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _reasonController,
              minLines: 3,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Reason',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Reason is required.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _submit,
              child: const Text('Submit Leave Application'),
            ),
          ],
        ),
      ),
    );
  }
}
