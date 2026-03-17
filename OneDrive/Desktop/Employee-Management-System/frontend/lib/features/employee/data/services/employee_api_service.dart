import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/employee_model.dart';

class EmployeeApiService {
  final ApiClient apiClient;

  EmployeeApiService(this.apiClient);

  Future<List<Employee>> fetchEmployees() async {
    final response = await apiClient.dio.get("/employees");

    final List employees = response.data["employees"];

    return employees.map((e) => Employee.fromJson(e)).toList();
  }

  Future<void> createEmployee(
    String name,
    String email,
    String department,
    String position,
    double salary,
  ) async {
    await apiClient.dio.post(
      "/employees",
      data: {
        "name": name,
        "email": email,
        "department": department,
        "position": position,
        "salary": salary,
      },
    );
  }

  Future<void> updateEmployee(Employee employee) async {
    await apiClient.dio.put(
      "/employees/${employee.id}",
      data: employee.toJson(),
    );
  }

  Future<void> deleteEmployee(String id) async {
    await apiClient.dio.delete("/employees/$id");
  }
}