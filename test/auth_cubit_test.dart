import 'dart:async';

import 'package:attendance/features/auth/domain/entities/app_user.dart';
import 'package:attendance/features/auth/domain/repositories/auth_repository.dart';
import 'package:attendance/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:attendance/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _FakeAuthRepository repository;
  late AuthCubit cubit;

  setUp(() {
    repository = _FakeAuthRepository();
    cubit = AuthCubit(repository);
  });

  tearDown(() async {
    await cubit.close();
    await repository.dispose();
  });

  test('auth stream updates the current authentication state', () async {
    final user = const AppUser(uid: 'user-id', email: 'user@example.com');
    final stateEmitted = expectLater(
      cubit.stream,
      emits(
        isA<AuthState>()
            .having((state) => state.status, 'status', AuthStatus.authenticated)
            .having((state) => state.user, 'user', user),
      ),
    );

    repository.authStateController.add(user);
    await stateEmitted;
  });

  test('sign-in failure clears loading and exposes the error', () async {
    final statesEmitted = expectLater(
      cubit.stream,
      emitsInOrder([
        isA<AuthState>().having((state) => state.isLoading, 'loading', true),
        isA<AuthState>()
            .having((state) => state.isLoading, 'loading', false)
            .having(
              (state) => state.errorMessage,
              'error message',
              contains('invalid credentials'),
            ),
      ]),
    );

    await cubit.signIn('user@example.com', 'wrong-password');
    await statesEmitted;
  });
}

class _FakeAuthRepository implements AuthRepository {
  final authStateController = StreamController<AppUser?>.broadcast();

  @override
  Stream<AppUser?> authStateChanges() => authStateController.stream;

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    throw Exception('invalid credentials');
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {}

  Future<void> dispose() => authStateController.close();
}
