
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k1/bottom_nav_bar_manager.dart';
import 'package:k1/fonts.dart';
import 'package:k1/ui/main_form.dart';
import 'package:k1/ui/test_page.dart';

import 'graph_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter K1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent)
        )
      ),
      home: MyHomePage(title: 'K1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Size get size => MediaQuery.of(context).size;
  BottomNavBarManager get bottomTabBarManager => BottomNavBarManager();
  GraphManager get graphManager => GraphManager();

  @override
  void initState() {
    graphManager.getRevenue();
    super.initState();
  }

  @override
  void dispose() {
    bottomTabBarManager.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NavBarScreen>(
        stream: bottomTabBarManager.navBarScreenStream,
        initialData: bottomTabBarManager.defaultScreen,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot navBarScreen) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backwardsCompatibility: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NLOK US',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: sfProTextMedium,
                    fontWeight: FontWeight.w700,
                  )),
                Text(
                  'NortonLifeLock',
                  style: TextStyle(
                    color: Color.fromRGBO(60, 60, 67, 170),
                    fontSize: 13,
                    fontFamily: sfProTextMedium,
                    fontWeight: FontWeight.w400
                  )),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          body: scaffoldBody(navBarScreen.data),
          bottomNavigationBar: BottomNavigationBar(
              onTap: bottomTabBarManager.changeScreen,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              elevation: 30,
              iconSize: 32,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.black,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: navBarScreen.data.index,
              unselectedFontSize: 10,
              selectedFontSize: 10,
              unselectedLabelStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontFamily: sfProTextMedium,
                fontWeight: FontWeight.w400
              ),
              selectedLabelStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
                fontFamily: sfProTextMedium,
                fontWeight: FontWeight.w400
              ),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.doc_text_search,
                      color: navBarScreen.data.index == 0 ? Colors.black : Colors.grey,
                    ),
                    label: 'Обзор',
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.news,
                      color: navBarScreen.data.index == 1 ? Colors.black : Colors.grey,
                    ),
                    label: 'Новости',
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.doc_plaintext,
                      color: navBarScreen.data.index == 2 ? Colors.black : Colors.grey,
                    ),
                    label: 'Показатели',
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.chart_pie,
                      color: navBarScreen.data.index == 3 ? Colors.black : Colors.grey,
                    ),
                    label: 'Аналитика',
                    backgroundColor: Colors.transparent),
                BottomNavigationBarItem(
                    icon: Icon(
                      CupertinoIcons.arrow_up_arrow_down_square,
                      color: navBarScreen.data.index == 4 ? Colors.black : Colors.grey,
                    ),
                    label: 'Сделки',
                    backgroundColor: Colors.transparent),
              ]),
        );
      }
    );
  }

  Widget scaffoldBody(NavBarScreen screen) {
    Widget currentWidget;
    switch (screen) {
      case NavBarScreen.First:
        currentWidget = MainForm();
        break;
      case NavBarScreen.Second:
        currentWidget = TestPage(text: 'Second Page');
        break;
      case NavBarScreen.Third:
        currentWidget = TestPage(text: 'Third Page');
        break;
      case NavBarScreen.Fourth:
        currentWidget = TestPage(text: 'Fourth Page');
        break;
      case NavBarScreen.Fifth:
        currentWidget = TestPage(text: 'Fifth Page');
        break;
    }
    return currentWidget;
  }
}
