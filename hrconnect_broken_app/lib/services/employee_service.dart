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
    //CHANGED: 
    //Issues: Case-sensitive， did not search department, position and employee ID

    //now the search function is ignores uppercase/lowercase differences 
    //can searches by name, department, position, and employee ID.

    final q = query.toLowerCase();

    return getEmployees().where((employee) {
      return employee.fullName.toLowerCase().contains(q) ||
          employee.department.toLowerCase().contains(q) ||
          employee.position.toLowerCase().contains(q) ||
          employee.id.toLowerCase().contains(q);
    }).toList();
  }
}
