import 'package:flutter/material.dart';

import 'screens/announcement_list_screen.dart';

const bool kModeSimulasi = bool.fromEnvironment('SIMULASI');

class Modul4App extends StatelessWidget {
  const Modul4App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modul 04 - Portal Pengumuman',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AnnouncementListScreen(),
    );
  }
}

void main() {
  runApp(const Modul4App());
}
