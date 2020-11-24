import 'dart:async';
import 'dart:developer' as developer;

import 'package:blogapp/Article/index.dart';
import 'package:blogapp/Home/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ArticleEvent {
  Stream<ArticleState> applyAsync(
      {ArticleState currentState, ArticleBloc bloc});
  final ArticleRepository _articleRepository = ArticleRepository();
}

class UnArticleEvent extends ArticleEvent {
  @override
  Stream<ArticleState> applyAsync(
      {ArticleState currentState, ArticleBloc bloc}) async* {
    yield UnArticleState(0);
  }
}

class LoadArticleEvent extends ArticleEvent {
  final Article article;
  @override
  String toString() => 'LoadArticleEvent';

  LoadArticleEvent(this.article);

  @override
  Stream<ArticleState> applyAsync(
      {ArticleState currentState, ArticleBloc bloc}) async* {
    try {
      yield UnArticleState(0);

      String articleData =
          await _articleRepository.generateHTMLFromMarkdown(article);
      yield InArticleState(0, article);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadArticleEvent', error: _, stackTrace: stackTrace);
      yield ErrorArticleState(0, _?.toString());
    }
  }
}
