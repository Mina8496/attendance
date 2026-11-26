import 'package:attendance/features/auth/presentation/pages/auth_gate.dart';
import 'package:attendance/features/auth/presentation/pages/register_page.dart';
import 'package:attendance/features/splash/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const kAuthGate = '/authGate';
  static const kSplashPage = '/splashPage';
  static const kRegisterPage = '/registerPage';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => AuthGate()),
      GoRoute(path: '/splashpage', builder: (context, state) => SplashPage()),
      GoRoute(path: '/registerPage', builder: (context, state) => RegisterPage()),
    ],
  );
}
