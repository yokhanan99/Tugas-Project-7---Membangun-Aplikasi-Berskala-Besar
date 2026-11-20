import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/async_body.dart';
import '../core/formatters.dart';
import 'announcements_view_model.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  late final AnnouncementsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AnnouncementsViewModel(repository: context.read());
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
      appBar: AppBar(title: const Text('Pengumuman')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return AsyncBody(
            isLoading: _viewModel.isLoading,
            error: _viewModel.error,
            onRetry: _viewModel.load,
            child: _viewModel.announcements.isEmpty
                ? const Center(child: Text('Belum ada pengumuman'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _viewModel.announcements.length,
                    itemBuilder: (context, i) {
                      final a = _viewModel.announcements[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.title, style: theme.textTheme.titleMedium),
                              const SizedBox(height: 4),
                              Text('${a.author} • ${formatDate(a.date)}',
                                  style: theme.textTheme.bodySmall),
                              const SizedBox(height: 8),
                              Text(a.body),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
