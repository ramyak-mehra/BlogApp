import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:blogapp/Featured/index.dart';

class FeaturedBloc extends Bloc<FeaturedEvent, FeaturedState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final FeaturedBloc _featuredBlocSingleton = FeaturedBloc._internal();
  factory FeaturedBloc() {
    return _featuredBlocSingleton;
  }
  FeaturedBloc._internal(): super(UnFeaturedState(0));
  
  @override
  Future<void> close() async{
    // dispose objects
    await super.close();
  }

  @override
  FeaturedState get initialState => UnFeaturedState(0);

  @override
  Stream<FeaturedState> mapEventToState(
    FeaturedEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'FeaturedBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
