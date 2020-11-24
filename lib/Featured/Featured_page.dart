import 'package:flutter/material.dart';
import 'package:blogapp/Featured/index.dart';

class FeaturedPage extends StatefulWidget {
  static const String routeName = '/featured';

  @override
  _FeaturedPageState createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {
  final _featuredBloc = FeaturedBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Featured'),
      ),
      body: FeaturedScreen(featuredBloc: _featuredBloc),
    );
  }
}
