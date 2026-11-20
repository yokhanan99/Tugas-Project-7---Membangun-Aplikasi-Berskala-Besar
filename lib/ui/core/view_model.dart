import 'package:flutter/foundation.dart';

/// Dasar semua ViewModel: menyediakan isLoading, error, dan helper runLoad().
abstract class ViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _disposed = false;

  bool get isLoading => _isLoading;
  String? get error => _error;

  @protected
  Future<void> runLoad(Future<void> Function() action) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await action();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
