class Attendance {
  final String employeeId;
  final DateTime? date;
  final String checkIn;
  final String checkOut;
  final String status;

  const Attendance({
    required this.employeeId,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      employeeId: json['employeeId']?.toString() ?? 'Unknown ID',
      date: json['date'] != null ? DateTime.tryParse(json['date'].toString()) : null,
      checkIn: json['checkIn']?.toString() ?? '-',
      checkOut: json['checkOut']?.toString() ?? '-',
      status: json['status']?.toString() ?? 'Unknown',
    );
  }

  bool get isLate => status.toLowerCase() == 'late';
}
