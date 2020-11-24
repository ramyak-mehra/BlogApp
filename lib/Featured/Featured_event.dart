import 'dart:async';
import 'dart:developer' as developer;

import 'package:blogapp/Featured/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FeaturedEvent {
  Stream<FeaturedState> applyAsync(
      {FeaturedState currentState, FeaturedBloc bloc});
  final FeaturedRepository _featuredRepository = FeaturedRepository();
}

class UnFeaturedEvent extends FeaturedEvent {
  @override
  Stream<FeaturedState> applyAsync({FeaturedState currentState, FeaturedBloc bloc}) async* {
    yield UnFeaturedState(0);
  }
}

class LoadFeaturedEvent extends FeaturedEvent {
   
  final bool isError;
  @override
  String toString() => 'LoadFeaturedEvent';

  LoadFeaturedEvent(this.isError);

  @override
  Stream<FeaturedState> applyAsync(
      {FeaturedState currentState, FeaturedBloc bloc}) async* {
    try {
      yield UnFeaturedState(0);
      await Future.delayed(Duration(seconds: 1));
      _featuredRepository.test(isError);
      yield InFeaturedState(0, 'Hello world');
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadFeaturedEvent', error: _, stackTrace: stackTrace);
      yield ErrorFeaturedState(0, _?.toString());
    }
  }
}
