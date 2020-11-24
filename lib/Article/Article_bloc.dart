import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:blogapp/Article/index.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final ArticleBloc _articleBlocSingleton = ArticleBloc._internal();
  factory ArticleBloc() {
    return _articleBlocSingleton;
  }
  ArticleBloc._internal(): super(UnArticleState(0));
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  ArticleState get initialState => UnArticleState(0);

  @override
  Stream<ArticleState> mapEventToState(
    ArticleEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ArticleBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
