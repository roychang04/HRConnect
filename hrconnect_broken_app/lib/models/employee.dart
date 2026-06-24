class Employee {
  final String id;
  final String fullName;
  final String department;
  final String position;
  final String email;
  final String phone;
  int leaveBalance;//remove final
  final String managerName;
  final bool isActive;

  Employee({
    required this.id,
    required this.fullName,
    required this.department,
    required this.position,
    required this.email,
    required this.phone,
    required this.leaveBalance,
    required this.managerName,
    required this.isActive,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'].toString(),
      fullName: json['fullName'].toString(),
      department: json['department'].toString(),
      position: json['position'].toString(),
      email: json['email'].toString(),
      phone: json['phone']?.toString() ?? '',
      leaveBalance: json['leaveBalance'] as int,
      managerName: json['managerName']?.toString() ?? '',
      isActive: json['isActive'] as bool,
    );
  }
}
