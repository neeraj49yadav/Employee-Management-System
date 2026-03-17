import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_client.dart';
import '../../data/models/employee_model.dart';
import '../../data/services/employee_api_service.dart';
import '../../data/repositories/employee_repository_impl.dart';

final employeeRepositoryProvider = Provider<EmployeeRepositoryImpl>((ref) {
  final api = EmployeeApiService(ref.read(apiClientProvider));
  return EmployeeRepositoryImpl(api);
});

class EmployeeNotifier extends StateNotifier<AsyncValue<List<Employee>>> {
  final EmployeeRepositoryImpl repo;

  List<Employee> _allEmployees = [];

  EmployeeNotifier(this.repo) : super(const AsyncLoading()) {
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    try {
      final data = await repo.fetchEmployees();

      _allEmployees = data;

      state = AsyncData(data);
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      state = AsyncData(_allEmployees);
      return;
    }

    final filtered = _allEmployees.where((emp) {
      return emp.name.toLowerCase().contains(query.toLowerCase()) ||
          emp.email.toLowerCase().contains(query.toLowerCase()) ||
          emp.department.toLowerCase().contains(query.toLowerCase());
    }).toList();

    state = AsyncData(filtered);
  }

  Future<void> createEmployee(
    String name,
    String email,
    String department,
    String position,
    double salary,
  ) async {
    try {
      await repo.createEmployee(
        name,
        email,
        department,
        position,
        salary,
      );

      await loadEmployees();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      await repo.updateEmployee(employee);

      await loadEmployees();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      await repo.deleteEmployee(id);

      await loadEmployees();
    } catch (e, stack) {
      state = AsyncError(e, stack);
    }
  }
}

final employeeProvider =
    StateNotifierProvider<EmployeeNotifier, AsyncValue<List<Employee>>>((ref) {
  final repo = ref.read(employeeRepositoryProvider);
  return EmployeeNotifier(repo);
});