import 'package:flutter/material.dart';
import './modul_02/academic_dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Poliwangi Academic Dashboard',
      debugShowCheckedModeBanner: false,
      home: AcademicDashboardScreen(),
    );
  }
}

void main() {
  runApp(const MyApp());
}