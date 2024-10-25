import 'package:car_workshop_app/screens/admin/admin_screen.dart';
import 'package:car_workshop_app/screens/authentication/auth_screen.dart';
import 'package:car_workshop_app/screens/mechanic/mechanic.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'controllers/auth_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter(
      initialLocation: '/auth',
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminScreen(),
        ),
        GoRoute(
          path: '/mechanic',
          builder: (context, state) => const MechanicScreen(),
        ),
      ],
      redirect: (context, state) {
        final user = ref.watch(authControllerProvider);
        if (user?.role == null) {
          return '/auth'; // Navigate to AuthScreen if no user is logged in
        } else {
          switch (user?.role) {
            case 'admin':
              return '/admin';
            case 'mechanic':
              return '/mechanic';
            default:
              return '/auth'; // Default case, if the role is not recognized
          }
        }
      },
    );

    return MaterialApp.router(
      routerConfig: goRouter,
    );
  }
}
