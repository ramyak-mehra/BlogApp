import 'package:blogapp/Home/index.dart';
import 'package:flutter/material.dart';
import 'package:blogapp/Article/index.dart';

class ArticlePage extends StatefulWidget {
  static const String routeName = '/article';
  final Article _article;
  ArticlePage({@required Article article}) : _article = article;
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final _articleBloc = ArticleBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article'),
      ),
      body: ArticleScreen(
        articleBloc: _articleBloc,
        article: widget._article,
      ),
    );
  }
}
