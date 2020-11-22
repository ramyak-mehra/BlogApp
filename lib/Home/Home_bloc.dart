import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:blogapp/Home/index.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  // todo: check singleton for logic in project
  // use GetIt for DI in projct
  static final HomeBloc _homeBlocSingleton = HomeBloc._internal();
  factory HomeBloc() {
    return _homeBlocSingleton;
  }
  HomeBloc._internal() : super(UnHomeState(0));

  @override
  Future<void> close() async {
    _homeBlocSingleton.close();
    await super.close();
  }

  HomeState get initialState => UnHomeState(0);

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'HomeBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
