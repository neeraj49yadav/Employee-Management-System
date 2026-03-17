import '../../domain/entities/employee.dart';
import '../../domain/entities/employee_filter.dart';

class EmployeeState {
  final List<Employee> employees;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final String searchQuery;
  final EmployeeFilter filter;
  final String? error;

  const EmployeeState({
    this.employees = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.totalPages = 1,
    this.totalCount = 0,
    this.searchQuery = '',
    this.filter = const EmployeeFilter(),
    this.error,
  });

  bool get hasMore => currentPage < totalPages;

  EmployeeState copyWith({
    List<Employee>? employees,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? totalPages,
    int? totalCount,
    String? searchQuery,
    EmployeeFilter? filter,
    String? error,
  }) {
    return EmployeeState(
      employees: employees ?? this.employees,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore:
          isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalCount: totalCount ?? this.totalCount,
      searchQuery: searchQuery ?? this.searchQuery,
      filter: filter ?? this.filter,
      error: error,
    );
  }
}
