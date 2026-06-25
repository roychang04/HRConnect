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
    const validStatuses = {'present', 'late', 'absent'};
    final status = json['status']?.toString().toLowerCase();

    return Attendance(
      employeeId: json['employeeId']?.toString() ?? '-',
      date: json['date'] != null ? DateTime.tryParse(json['date'].toString()) : null,
      checkIn: json['checkIn']?.toString() ?? '-',
      checkOut: json['checkOut']?.toString() ?? '-',
      status: (status == null || !validStatuses.contains(status))
              ? '-'
              : status[0].toUpperCase() + status.substring(1)
    );
  }

  bool get isLate => status.toLowerCase() == 'late';
  bool get isNull => status == '-';
  bool get isAbsent => status.toLowerCase() == 'absent';
}
