import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/base_state.dart';
import 'package:taskapp/services/user_service.dart';

class LoginState extends BaseState<LoginState> {
  const LoginState({
    bool isLoading = false,
    String? failure,
  }) : super(isLoading, failure);

  @override
  List<Object?> get props => [];

  LoginState copyWith({String? failure, bool? isLoading}) {
    return LoginState(
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

class LoginPageProvider extends PageProvider<LoginState> {
  late TextEditingController emailController, passwordController;
  late GlobalKey<FormState> formKey;
  late UserService _user;

  LoginPageProvider() : super(const LoginState()) {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    _user = UserService();
  }

  Future<bool> onLoginPressed() async {
    if (formKey.currentState!.validate()) {
      String response = await _user.logIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response == 'Logged in') {
        showSuccessToast(message: response);

        return true;
      }

      emitFailure(response);
    }

    return false;
  }
}

final loginPageProvider =
    StateNotifierProvider.autoDispose<LoginPageProvider, LoginState>(
  (_) => LoginPageProvider(),
);
