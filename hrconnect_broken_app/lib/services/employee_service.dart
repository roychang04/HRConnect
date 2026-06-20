import '../data/mock_hr_data.dart';
import '../models/employee.dart';

class EmployeeService {
  const EmployeeService();

  List<Employee> getEmployees() {
    return mockEmployees.map(Employee.fromJson).toList();
  }

  Employee? getEmployeeById(String id) {
    for (final employee in getEmployees()) {
      if (employee.id == id) return employee;
    }
    return null;
  }

  List<Employee> searchEmployees(String query) {
    if (query.isEmpty) return getEmployees();

    return getEmployees().where((employee) {
      return employee.fullName.contains(query);
    }).toList();
  }
}
