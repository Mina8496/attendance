import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  AppUser _map(dynamic user) => AppUser(
        uid: user.uid as String,
        email: user.email as String?,
        displayName: user.displayName as String?,
      );

  @override
  Stream<AppUser?> authStateChanges() =>
      _remote.authStateChanges().map((user) => user == null ? null : _map(user));

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async =>
      _map(await _remote.signIn(email, password));

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
  }) async =>
      _map(await _remote.signUp(email, password));

  @override
  Future<void> signOut() => _remote.signOut();
}
