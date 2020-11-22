import 'package:blogapp/Home/Home_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final List propss;
  HomeState(this.version, [this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  HomeState getStateCopy();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnHomeState extends HomeState {
  UnHomeState(int version) : super(version);

  @override
  String toString() => 'UnHomeState';

  @override
  UnHomeState getStateCopy() {
    return UnHomeState(0);
  }

  @override
  UnHomeState getNewVersion() {
    return UnHomeState(version + 1);
  }
}

/// Initialized
class InHomeState extends HomeState {
  final Results results;

  InHomeState(int version, this.results) : super(version, [results]);

  @override
  String toString() => 'InHomeState Data';

  @override
  InHomeState getStateCopy() {
    return InHomeState(version, results);
  }
}

class ErrorHomeState extends HomeState {
  final String errorMessage;

  ErrorHomeState(int version, this.errorMessage)
      : super(version, [errorMessage]);

  @override
  String toString() => 'ErrorHomeState';

  @override
  ErrorHomeState getStateCopy() {
    return ErrorHomeState(version, errorMessage);
  }

  @override
  ErrorHomeState getNewVersion() {
    return ErrorHomeState(version + 1, errorMessage);
  }
}
