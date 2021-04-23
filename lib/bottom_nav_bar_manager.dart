import 'dart:async';

// enum to denote screens in the BottomTabBar
enum NavBarScreen { First, Second, Third, Fourth, Fifth }

// Manager for managing tabs BottomTaBar
class BottomNavBarManager {
  static final _instance = BottomNavBarManager._();
  factory BottomNavBarManager() => _instance;
  BottomNavBarManager._();

  // Stream responsible for navigation between tabs BottomTabBar
  final StreamController<NavBarScreen> navBarScreenSC = StreamController.broadcast();
  Stream<NavBarScreen> get navBarScreenStream => navBarScreenSC.stream;

  // Default tab BottomTabBar
  NavBarScreen defaultScreen = NavBarScreen.First;
  // Current tab BottomTabBar
  NavBarScreen currentScreen = NavBarScreen.First;

  // The method responsible for changing the current tab BottomTabBar
  void changeScreen(int i) {
    switch (i) {
      case 0:
        currentScreen = NavBarScreen.First;
        navBarScreenSC.sink.add(NavBarScreen.First);
        break;
      case 1:
        currentScreen = NavBarScreen.Second;
        navBarScreenSC.sink.add(NavBarScreen.Second);
        break;
      case 2:
        currentScreen = NavBarScreen.Third;
        navBarScreenSC.sink.add(NavBarScreen.Third);
        break;
      case 3:
        currentScreen = NavBarScreen.Fourth;
        navBarScreenSC.sink.add(NavBarScreen.Fourth);
        break;
      case 4:
        currentScreen = NavBarScreen.Fifth;
        navBarScreenSC.sink.add(NavBarScreen.Fifth);
        break;
    }
  }

  // Close the stream when closing the application
  close() {
    navBarScreenSC.close();
  }

}