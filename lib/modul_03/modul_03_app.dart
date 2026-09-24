import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GoRouter modul03Router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('KRS & State Management TRPL')),
      ),
    ),
  ],
);

class Modul03App extends StatelessWidget {
  const Modul03App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'KRS & State Management TRPL',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
          useMaterial3: true,
        ),
        routerConfig: modul03Router,
      ),
    );
  }
}

void mmain() {
  runApp(const Modul03App());
}
