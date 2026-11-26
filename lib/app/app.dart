import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/pages/auth_gate.dart';
import '../features/auth/presentation/pages/register_page.dart';

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(FirebaseAuthRemoteDataSource()),
      child: BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
        child: MaterialApp(
          title: 'Attendance',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const AuthGate(),
          routes: {AppRoutes.register: (_) => const RegisterPage()},
        ),
      ),
    );
  }
}
