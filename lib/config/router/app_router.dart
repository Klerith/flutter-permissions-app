import 'package:go_router/go_router.dart';

import 'package:miscelaneos/presentation/screens/screens.dart';

final router = GoRouter(
  routes: [
  
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),



]);