import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:employee_management/features/employee/presentation/providers/employee_provider.dart';
import 'package:employee_management/features/employee/domain/repositories/employee_repository.dart';
import 'package:employee_management/features/employee/data/models/paginated_employee_response.dart';
import 'package:employee_management/features/employee/domain/entities/employee.dart';
import 'package:employee_management/features/employee/domain/entities/employee_filter.dart';

class MockRepository extends Mock implements EmployeeRepository {}

class FakeEmployeeFilter extends Fake implements EmployeeFilter {}

void main() {
  late MockRepository mockRepository;
  late EmployeeNotifier notifier;

  setUpAll(() {
    registerFallbackValue(FakeEmployeeFilter());
  });

  setUp(() {
    mockRepository = MockRepository();
    notifier = EmployeeNotifier(mockRepository);
  });

  test('fetchEmployees loads first page', () async {
    when(() => mockRepository.fetchEmployees(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          search: any(named: 'search'),
          filter: any(named: 'filter'),
        )).thenAnswer(
      (_) async => PaginatedEmployeeResponse(
        employees: [],
        currentPage: 1,
        totalPages: 1,
        totalCount: 0,
      ),
    );

    await notifier.fetchEmployees();

    expect(notifier.state.currentPage, 1);
  });
}
