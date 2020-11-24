import 'package:blogapp/Article/Article_page.dart';
import 'package:blogapp/Home/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      darkTheme: ThemeData.dark(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomePage());

          case ArticlePage.routeName:
            return MaterialPageRoute(
                builder: (_) => ArticlePage(article: settings.arguments));
        }
        return MaterialPageRoute(builder: (_) => HomePage());
      },
    );
  }
}
