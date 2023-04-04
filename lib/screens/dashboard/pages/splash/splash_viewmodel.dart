import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/base_state.dart';
import 'package:taskapp/services/user_service.dart';

class SplashState extends BaseState<SplashState> {
  const SplashState({
    bool isLoading = false,
    String? failure,
  }) : super(isLoading, failure);

  @override
  List<Object?> get props => [];

  SplashState copyWith({String? failure, bool? isLoading}) {
    return SplashState(
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

class SplashPageProvider extends PageProvider<SplashState> {
  late UserService _user;
  SplashPageProvider() : super(const SplashState()) {
    _user = UserService();
  }

  Future<bool> onModelReady() async {
    bool loggedIn = await _user.isLoggedIn();

    if (loggedIn) {
      return true;
    }

    return false;
  }
}

final splashPageProvider =
    StateNotifierProvider.autoDispose<SplashPageProvider, SplashState>(
  (_) => SplashPageProvider(),
);
