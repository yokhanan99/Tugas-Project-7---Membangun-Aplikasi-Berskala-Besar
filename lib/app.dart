import 'package:flutter/material.dart';

import 'ui/shell/app_shell.dart';

class NusaKampusApp extends StatelessWidget {
  const NusaKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaKampus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const AppShell(),
    );
  }
}
