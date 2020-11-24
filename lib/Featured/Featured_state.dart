import 'package:equatable/equatable.dart';

abstract class FeaturedState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  FeaturedState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  FeaturedState getStateCopy();

  FeaturedState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnFeaturedState extends FeaturedState {

  UnFeaturedState(int version) : super(version);

  @override
  String toString() => 'UnFeaturedState';

  @override
  UnFeaturedState getStateCopy() {
    return UnFeaturedState(0);
  }

  @override
  UnFeaturedState getNewVersion() {
    return UnFeaturedState(version+1);
  }
}

/// Initialized
class InFeaturedState extends FeaturedState {
  final String hello;

  InFeaturedState(int version, this.hello) : super(version, [hello]);

  @override
  String toString() => 'InFeaturedState $hello';

  @override
  InFeaturedState getStateCopy() {
    return InFeaturedState(version, hello);
  }

  @override
  InFeaturedState getNewVersion() {
    return InFeaturedState(version+1, hello);
  }
}

class ErrorFeaturedState extends FeaturedState {
  final String errorMessage;

  ErrorFeaturedState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorFeaturedState';

  @override
  ErrorFeaturedState getStateCopy() {
    return ErrorFeaturedState(version, errorMessage);
  }

  @override
  ErrorFeaturedState getNewVersion() {
    return ErrorFeaturedState(version+1, 
    errorMessage);
  }
}
