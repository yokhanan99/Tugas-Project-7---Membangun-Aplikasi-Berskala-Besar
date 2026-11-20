import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/async_body.dart';
import 'schedule_view_model.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ScheduleViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ScheduleViewModel(scheduleRepository: context.read());
    _viewModel.load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jadwal Kuliah')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<int>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 1, label: Text('Sen')),
                      ButtonSegment(value: 2, label: Text('Sel')),
                      ButtonSegment(value: 3, label: Text('Rab')),
                      ButtonSegment(value: 4, label: Text('Kam')),
                      ButtonSegment(value: 5, label: Text('Jum')),
                    ],
                    selected: {_viewModel.selectedDay},
                    onSelectionChanged: (s) => _viewModel.selectDay(s.first),
                  ),
                ),
              ),
              Expanded(
                child: AsyncBody(
                  isLoading: _viewModel.isLoading,
                  error: _viewModel.error,
                  onRetry: _viewModel.load,
                  child: _viewModel.courses.isEmpty
                      ? const Center(child: Text('Tidak ada kuliah pada hari ini'))
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _viewModel.courses.length,
                          itemBuilder: (context, i) {
                            final c = _viewModel.courses[i];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.menu_book_outlined),
                                title: Text(c.name),
                                subtitle: Text(
                                    '${c.startTime} - ${c.endTime} • ${c.room}\n${c.lecturer}'),
                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
