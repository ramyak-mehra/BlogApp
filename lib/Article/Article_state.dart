import 'package:blogapp/Home/Home_model.dart';
import 'package:equatable/equatable.dart';

abstract class ArticleState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final List propss;
  ArticleState(this.version, [this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ArticleState getStateCopy();

  ArticleState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnArticleState extends ArticleState {
  UnArticleState(int version) : super(version);

  @override
  String toString() => 'UnArticleState';

  @override
  UnArticleState getStateCopy() {
    return UnArticleState(0);
  }

  @override
  UnArticleState getNewVersion() {
    return UnArticleState(version + 1);
  }
}

/// Initialized
class InArticleState extends ArticleState {
  final Article articleData;

  InArticleState(int version, this.articleData) : super(version, [articleData]);

  @override
  String toString() => 'InArticleState';

  @override
  InArticleState getStateCopy() {
    return InArticleState(version, articleData);
  }

  @override
  InArticleState getNewVersion() {
    return InArticleState(version + 1, articleData);
  }
}

class ErrorArticleState extends ArticleState {
  final String errorMessage;

  ErrorArticleState(int version, this.errorMessage)
      : super(version, [errorMessage]);

  @override
  String toString() => 'ErrorArticleState';

  @override
  ErrorArticleState getStateCopy() {
    return ErrorArticleState(version, errorMessage);
  }

  @override
  ErrorArticleState getNewVersion() {
    return ErrorArticleState(version + 1, errorMessage);
  }
}
