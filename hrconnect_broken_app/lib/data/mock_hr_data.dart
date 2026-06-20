const List<Map<String, dynamic>> mockUsers = [
  {
    'id': 'U001',
    'employeeId': 'E001',
    'fullName': 'Aina Rahman',
    'email': 'hr@company.com',
    'password': 'hr123',
    'role': 'HR',
  },
  {
    'id': 'U002',
    'employeeId': 'E002',
    'fullName': 'Daniel Tan',
    'email': 'employee@company.com',
    'password': 'emp123',
    'role': 'Employee',
  },
];

const List<Map<String, dynamic>> mockEmployees = [
  {
    'id': 'E001',
    'fullName': 'Aina Rahman',
    'department': 'Human Resource',
    'position': 'HR Executive',
    'email': 'aina.rahman@company.com',
    'phone': '012-111 2233',
    'leaveBalance': 14,
    'managerName': 'Farah Ismail',
    'isActive': true,
  },
  {
    'id': 'E002',
    'fullName': 'Daniel Tan',
    'department': 'Information Technology',
    'position': 'Mobile Developer',
    'email': 'daniel.tan@company.com',
    'phone': '013-222 3344',
    'leaveBalance': 9,
    'managerName': 'Aina Rahman',
    'isActive': true,
  },
  {
    'id': 'E003',
    'fullName': 'Nur Iman',
    'department': 'Finance',
    'position': 'Account Executive',
    'email': 'nur.iman@company.com',
    'phone': null,
    'leaveBalance': 11,
    'managerName': 'Farah Ismail',
    'isActive': true,
  },
  {
    'id': 'E004',
    'fullName': 'Jason Lee',
    'department': 'Marketing',
    'position': 'Content Strategist',
    'email': 'jason.lee@company.com',
    'phone': '019-555 6677',
    'leaveBalance': 7,
    'managerName': 'Aina Rahman',
    'isActive': false,
  },
];

const List<Map<String, dynamic>> mockAttendance = [
  {
    'employeeId': 'E001',
    'date': '2026-06-10',
    'checkIn': '08:45',
    'checkOut': '17:30',
    'status': 'Present',
  },
  {
    'employeeId': 'E002',
    'date': '2026-06-10',
    'checkIn': '09:25',
    'checkOut': '17:45',
    'status': 'Late',
  },
  {
    'employeeId': 'E003',
    'date': '2026-06-10',
    'checkIn': '08:55',
    'checkOut': '17:15',
    'status': 'Present',
  },
  {
    'employeeId': 'E004',
    'date': '2026-06-10',
    'checkIn': '-',
    'checkOut': '-',
    'status': 'Absent',
  },
];

const List<String> leaveTypes = [
  'Annual Leave',
  'Medical Leave',
  'Emergency Leave',
  'Unpaid Leave',
];
