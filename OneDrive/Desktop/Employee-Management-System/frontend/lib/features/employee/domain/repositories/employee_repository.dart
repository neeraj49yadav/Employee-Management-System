import '../../data/models/paginated_employee_response.dart';
import '../entities/employee.dart';
import '../entities/employee_filter.dart';

abstract class EmployeeRepository {
  Future<PaginatedEmployeeResponse> fetchEmployees({
    required int page,
    required int limit,
    required String search,
    required EmployeeFilter filter,
  });

  Future<Employee> createEmployee({
    required String name,
    required String email,
    required String role,
  });

  Future<Employee> updateEmployee({
    required String id,
    required String name,
    required String email,
    required String role,
  });

  Future<void> deleteEmployee(String id);
}
