import 'package:k1/models/revenue.dart';

import 'repository/revenue_repository.dart';

// Manager for managing and storing the received data
class GraphManager {
  static final _instance = GraphManager._();
  factory GraphManager() => _instance;
  GraphManager._();

  RevenueRepository get revenueRepository => RevenueRepository();
  late Revenue currentRevenue;

  // Retrieving test data from the repository
  void getRevenue() {
    currentRevenue = revenueRepository.fetchRevenue();
  }
}