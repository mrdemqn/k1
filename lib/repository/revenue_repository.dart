import 'dart:math';

import 'package:k1/models/revenue.dart';

// Class for building requests to the network
class RevenueRepository {
  static final _instance = RevenueRepository._();
  factory RevenueRepository() => _instance;
  RevenueRepository._();

  // Simulate a request to get data
  Revenue fetchRevenue() {
    return Revenue(
      year: getRandomRevenue(90),
      sixMonth: getRandomRevenue(70),
      month: getRandomRevenue(60),
      week: getRandomRevenue(50),
      day: getRandomRevenue(40),
      hour: getRandomRevenue(30)
    );
  }

  List<double> getRandomRevenue(int rightAmount) {
    List<double> list = [];
    Random random = Random();
    for (int i = 0; i < rightAmount; i++) {
      list.add(random.nextInt(100).toDouble());
    }
    return list;
  }
}