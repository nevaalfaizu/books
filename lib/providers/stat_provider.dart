import 'package:flutter/material.dart';
import '../models/stat_response.dart';
import '../services/stat_service.dart';

class StatProvider with ChangeNotifier {
  StatResponse? _stats;

  StatResponse? get stats => _stats;

  Future<void> loadStats() async {
    _stats = await StatService.fetchStats();
    notifyListeners();
  }
}
