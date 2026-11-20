import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/async_body.dart';
import '../core/formatters.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      scheduleRepository: context.read(),
      taskRepository: context.read(),
    );
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return AsyncBody(
            isLoading: _viewModel.isLoading,
            error: _viewModel.error,
            onRetry: _viewModel.load,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text('Halo, Mahasiswa NusaKampus!',
                    style: theme.textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(formatFullDate(DateTime.now()),
                    style: theme.textTheme.bodyMedium),
                const SizedBox(height: 24),
                Text('Kuliah Hari Ini', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                if (_viewModel.todayCourses.isEmpty)
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.beach_access_outlined),
                      title: Text('Tidak ada kuliah hari ini'),
                    ),
                  )
                else
                  for (final c in _viewModel.todayCourses)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.school_outlined),
                        title: Text(c.name),
                        subtitle: Text(
                            '${c.startTime} - ${c.endTime} • ${c.room}\n${c.lecturer}'),
                        isThreeLine: true,
                      ),
                    ),
                const SizedBox(height: 24),
                Text(
                    'Tugas Belum Selesai (${_viewModel.pendingTasks.length})',
                    style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                if (_viewModel.pendingTasks.isEmpty)
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.celebration_outlined),
                      title: Text('Semua tugas sudah selesai!'),
                    ),
                  )
                else
                  for (final t in _viewModel.pendingTasks)
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.assignment_outlined),
                        title: Text(t.title),
                        subtitle: Text(
                            '${t.courseName} • ${dueLabel(t.dueDate)}'),
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
