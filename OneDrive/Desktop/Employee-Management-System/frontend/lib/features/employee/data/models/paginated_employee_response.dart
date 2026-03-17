import '../../domain/entities/employee.dart';

class PaginatedEmployeeResponse {
  final List<Employee> employees;
  final int currentPage;
  final int totalPages;
  final int totalCount;

  const PaginatedEmployeeResponse({
    required this.employees,
    required this.currentPage,
    required this.totalPages,
    required this.totalCount,
  });

  factory PaginatedEmployeeResponse.fromJson(
      Map<String, dynamic> json) {
    final rawList = json['employees'] as List<dynamic>? ?? [];

    final employees = rawList.map((e) {
      final map = e as Map<String, dynamic>;

      return Employee(
        id: map['id']?.toString() ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        role: map['role'] ?? '',
        isActive: map['isActive'] ?? false,
        createdAt: map['createdAt'] != null
            ? DateTime.parse(map['createdAt'])
            : DateTime.now(),
      );
    }).toList();

    return PaginatedEmployeeResponse(
      employees: employees,
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      totalCount: json['totalCount'] ?? employees.length,
    );
  }
}
