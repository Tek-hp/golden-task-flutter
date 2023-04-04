import 'package:equatable/equatable.dart';

abstract class BaseState<S> extends Equatable {
  final bool isLoading;
  final String? failure;

  const BaseState(this.isLoading, this.failure);

  BaseState setLoading(bool loading);

  BaseState setFailure(String? failure);
}
