import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/task.dart';
import '../core/async_body.dart';
import '../core/formatters.dart';
import 'tasks_view_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TasksViewModel(taskRepository: context.read());
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
      appBar: AppBar(title: const Text('Tugas')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final pending = _viewModel.pendingTasks;
          final done = _viewModel.doneTasks;
          return AsyncBody(
            isLoading: _viewModel.isLoading,
            error: _viewModel.error,
            onRetry: _viewModel.load,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _SectionHeader('Belum Selesai (${pending.length})'),
                if (pending.isEmpty)
                  const ListTile(title: Text('Tidak ada tugas tertunda 🎉')),
                for (final t in pending) _taskTile(t, theme),
                const Divider(height: 32),
                _SectionHeader('Selesai (${done.length})'),
                if (done.isEmpty)
                  const ListTile(title: Text('Belum ada tugas yang selesai')),
                for (final t in done) _taskTile(t, theme),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _taskTile(Task t, ThemeData theme) {
    return CheckboxListTile(
      key: ValueKey(t.id),
      value: t.isDone,
      onChanged: (_) => _viewModel.toggleTask(t.id),
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        t.title,
        style: t.isDone
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: Text('${t.courseName} • ${dueLabel(t.dueDate)}'),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
