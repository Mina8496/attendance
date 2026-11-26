import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) => IconButton(
              onPressed: state.isLoading
                  ? null
                  : context.read<AuthCubit>().signOut,
              icon: const Icon(Icons.logout),
              tooltip: 'Sign out',
            ),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => previous.user != current.user,
          builder: (context, state) => Text(
            'Welcome${state.user?.email == null ? '' : ', ${state.user!.email}'}',
          ),
        ),
      ),
    );
  }
}
