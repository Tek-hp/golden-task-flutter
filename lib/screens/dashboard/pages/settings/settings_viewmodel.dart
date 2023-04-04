import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/base_state.dart';
import 'package:taskapp/base/theme/theme_provider.dart';
import 'package:taskapp/services/user_service.dart';

class SettingsState extends BaseState<SettingsState> {
  const SettingsState({
    bool isLoading = false,
    String? failure,
  }) : super(isLoading, failure);

  @override
  List<Object?> get props => [];

  SettingsState copyWith({String? failure, bool? isLoading}) {
    return SettingsState(
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

class SettingsPageProvider extends PageProvider<SettingsState> {
  late UserService _user;
  SettingsPageProvider() : super(const SettingsState()) {
    _user = UserService();
  }

  Future<bool> onLogoutPressed() async {
    String status = await _user.logout();

    if (status == "Logged out") {
      showToast('Logged out');
      return true;
    }

    showToast(status);
    return false;
  }

  onChangeThemePressed(WidgetRef ref, ThemeMode theme) {
    ref.read(themeModeProvider.notifier).state =
        theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final settingsPageProvider =
    StateNotifierProvider.autoDispose<SettingsPageProvider, SettingsState>(
  (_) => SettingsPageProvider(),
);
