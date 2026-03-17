import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:employee_management/core/network/api_client.dart';
import 'package:employee_management/core/storage/secure_storage_service.dart';
import 'package:employee_management/features/auth/data/repositories/auth_repository_impl.dart';

class MockApiClient extends Mock implements ApiClient {}
class MockDio extends Mock implements Dio {}
class MockStorage extends Mock implements SecureStorageService {}

void main() {
  late MockApiClient mockApiClient;
  late MockDio mockDio;
  late MockStorage mockStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockApiClient = MockApiClient();
    mockDio = MockDio();
    mockStorage = MockStorage();

    when(() => mockApiClient.dio).thenReturn(mockDio);

    repository = AuthRepositoryImpl(
      mockApiClient,
      mockStorage,
    );
  });

  group('AuthRepositoryImpl', () {
    test('login returns mapped user', () async {
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
          )).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: {
            'data': {
              'user': {
                'id': '1',
                'name': 'Neeraj',
                'email': 'neeraj@test.com',
                'permissions': ['READ', 'WRITE'],
              },
              'token': 'abc123',
            }
          },
        ),
      );

      when(() => mockStorage.saveAccessToken(any()))
          .thenAnswer((_) async {});

      final user = await repository.login(
        'neeraj@test.com',
        '123456',
      );

      expect(user.id, '1');
      expect(user.name, 'Neeraj');
      expect(user.email, 'neeraj@test.com');
      expect(user.permissions.length, 2);

      verify(() => mockStorage.saveAccessToken('abc123')).called(1);
    });

    test('login throws when API fails', () async {
      when(() => mockDio.post(
            any(),
            data: any(named: 'data'),
          )).thenThrow(Exception());

      expect(
        () => repository.login(
          'wrong@test.com',
          'wrong',
        ),
        throwsException,
      );
    });

    test('logout clears storage', () async {
      when(() => mockStorage.clear())
          .thenAnswer((_) async {});

      await repository.logout();

      verify(() => mockStorage.clear()).called(1);
    });
  });
}
