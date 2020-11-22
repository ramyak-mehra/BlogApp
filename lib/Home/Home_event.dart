import 'dart:async';
import 'dart:developer' as developer;

import 'package:blogapp/Home/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  Stream<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
  final HomeRepository _homeRepository = HomeRepository();
}

class LoadHomeEvent extends HomeEvent {
  String toString() => 'LoadHomeEvent';

  @override
  Stream<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async* {
    try {
      yield UnHomeState(0);
      Results results = await _homeRepository.getAllArticles();
      if (results != null)
        yield InHomeState(0, results);
      else
        yield ErrorHomeState(0, 'Artuckes Could Not Be Fetched');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadHomeEvent', error: _, stackTrace: stackTrace);
      yield ErrorHomeState(0, _?.toString());
    }
  }
}

class FavoriteArticleEvent extends HomeEvent {
  final String articleSlug;
  FavoriteArticleEvent({this.articleSlug});
  String toString() => 'Follow Article Event';

  @override
  Stream<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async* {
    bool res = await _homeRepository.followArticle(articleSlug);
    if (res == true)
      yield InHomeState(currentState.version + 1, currentState.props[1]);
    else
      yield InHomeState(currentState.version, currentState.props[1]);
  }
}
