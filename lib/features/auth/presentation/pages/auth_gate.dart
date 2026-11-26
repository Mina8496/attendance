import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../splash/presentation/pages/splash_page.dart';
import 'login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          switch (state.status) {
            case AuthStatus.initializing:
              return const SplashPage();
            case AuthStatus.authenticated:
              return const HomePage();
            case AuthStatus.unauthenticated:
              return const LoginPage();
          }
        },
      ),
    );
  }
}
