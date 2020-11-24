import 'package:blogapp/Home/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogapp/Article/index.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({
    Key key,
    @required Article article,
    @required ArticleBloc articleBloc,
  })  : _articleBloc = articleBloc,
        _article = article,
        super(key: key);

  final ArticleBloc _articleBloc;
  final Article _article;
  @override
  ArticleScreenState createState() {
    return ArticleScreenState();
  }
}

class ArticleScreenState extends State<ArticleScreen> {
  ArticleScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
        cubit: widget._articleBloc,
        builder: (
          BuildContext context,
          ArticleState currentState,
        ) {
          if (currentState is UnArticleState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorArticleState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InArticleState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.articleData.author.username),
                  Text('Flutter files: done'),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text('throw error'),
                      onPressed: () => _load(true),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load([bool isError = false]) {
    widget._articleBloc.add(LoadArticleEvent(widget._article));
  }
}
