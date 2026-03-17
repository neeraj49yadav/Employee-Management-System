import '../models/employee_model.dart';

abstract class EmployeeRepository {
  Future<List<Employee>> fetchEmployees();

  Future<void> createEmployee(
    String name,
    String email,
    String department,
  );

  Future<void> updateEmployee(Employee employee);

  Future<void> deleteEmployee(String id);
}