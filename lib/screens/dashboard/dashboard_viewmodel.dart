import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/base_state.dart';

class DashboardState extends BaseState<DashboardState> {
  const DashboardState({
    bool isLoading = false,
    String? failure,
  }) : super(isLoading, failure);

  @override
  List<Object?> get props => [];

  DashboardState copyWith({String? failure, bool? isLoading}) {
    return DashboardState(
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  BaseState setFailure(String? failure) {
    return copyWith(failure: failure);
  }

  @override
  BaseState setLoading(bool loading) {
    return copyWith(isLoading: loading);
  }
}

class DashboardPageProvider extends PageProvider<DashboardState> {
  DashboardPageProvider() : super(const DashboardState());
}

final dashboardPageProvider =
    StateNotifierProvider.autoDispose<DashboardPageProvider, DashboardState>(
  (_) => DashboardPageProvider(),
);
