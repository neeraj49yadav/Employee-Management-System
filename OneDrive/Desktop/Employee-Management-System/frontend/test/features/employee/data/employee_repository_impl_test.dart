import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:employee_management/core/network/api_client.dart';
import 'package:employee_management/features/employee/data/repositories/employee_repository_impl.dart';
import 'package:employee_management/features/employee/domain/entities/employee_filter.dart';

class MockApiClient extends Mock implements ApiClient {}
class MockDio extends Mock implements Dio {}

void main() {
  late MockApiClient mockApiClient;
  late MockDio mockDio;
  late EmployeeRepositoryImpl repository;

  setUp(() {
    mockApiClient = MockApiClient();
    mockDio = MockDio();

    when(() => mockApiClient.dio).thenReturn(mockDio);

    repository = EmployeeRepositoryImpl(mockApiClient);
  });

  test('fetchEmployees returns paginated response', () async {
    when(() => mockDio.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: {
          'data': [],
          'meta': {
            'currentPage': 1,
            'totalPages': 1,
            'totalCount': 0,
          }
        },
      ),
    );

    final result = await repository.fetchEmployees(
      page: 1,
      limit: 10,
      search: '',
      filter: const EmployeeFilter(),
    );

    expect(result.currentPage, 1);
    expect(result.totalPages, 1);
  });

  test('createEmployee returns mapped employee', () async {
    when(() => mockDio.post(
          any(),
          data: any(named: 'data'),
        )).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: {
          'id': '1',
          'name': 'John',
          'email': 'john@test.com',
          'role': 'ADMIN',
          'isActive': true,
          'createdAt': DateTime.now().toIso8601String(),
        },
      ),
    );

    final employee = await repository.createEmployee(
      name: 'John',
      email: 'john@test.com',
      role: 'ADMIN',
    );

    expect(employee.id, '1');
    expect(employee.name, 'John');
  });

  test('deleteEmployee calls DELETE', () async {
    when(() => mockDio.delete(any())).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ''),
        data: {},
      ),
    );

    await repository.deleteEmployee('1');

    verify(() => mockDio.delete(any())).called(1);
  });
}
