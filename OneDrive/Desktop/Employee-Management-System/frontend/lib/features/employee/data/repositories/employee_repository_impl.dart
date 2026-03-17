import '../models/employee_model.dart';
import '../services/employee_api_service.dart';

class EmployeeRepositoryImpl {
  final EmployeeApiService api;

  EmployeeRepositoryImpl(this.api);

  Future<List<Employee>> fetchEmployees() async {
    return await api.fetchEmployees();
  }

  Future<void> createEmployee(
    String name,
    String email,
    String department,
    String position,
    double salary,
  ) async {
    await api.createEmployee(
      name,
      email,
      department,
      position,
      salary,
    );
  }

  Future<void> updateEmployee(Employee employee) async {
    await api.updateEmployee(employee);
  }

  Future<void> deleteEmployee(String id) async {
    await api.deleteEmployee(id);
  }
}