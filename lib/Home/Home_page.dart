import 'package:flutter/material.dart';
import 'package:blogapp/Home/index.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeBloc = HomeBloc();
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Bookmarked')
        ],
        onTap: (val) {},
      ),
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen(homeBloc: _homeBloc),
          HomeScreen(homeBloc: _homeBloc)
        ],
      ),
    );
  }
}
