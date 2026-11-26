import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState.initial()) {
    _subscription = _repository.authStateChanges().listen(
      _onAuthStateChanged,
      onError: (Object error) {
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            clearUser: true,
            errorMessage: error.toString(),
            isLoading: false,
          ),
        );
      },
    );
  }

  final AuthRepository _repository;
  late final StreamSubscription<AppUser?> _subscription;

  void _onAuthStateChanged(AppUser? user) {
    emit(
      state.copyWith(
        status: user == null
            ? AuthStatus.unauthenticated
            : AuthStatus.authenticated,
        user: user,
        clearUser: user == null,
        isLoading: false,
        clearError: true,
      ),
    );
  }

  Future<void> signIn(String email, String password) async {
    await _run(() => _repository.signIn(email: email, password: password));
  }

  Future<void> signUp(String email, String password) async {
    await _run(() => _repository.signUp(email: email, password: password));
  }

  Future<void> signOut() async {
    await _run(_repository.signOut);
  }

  Future<void> _run(Future<void> Function() action) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      await action();
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
