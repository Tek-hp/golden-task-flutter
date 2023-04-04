import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/base_state.dart';
import 'package:taskapp/models/user_model.dart';
import 'package:taskapp/services/user_service.dart';

class SignUpState extends BaseState<SignUpState> {
  const SignUpState({
    bool isLoading = false,
    String? failure,
  }) : super(isLoading, failure);

  @override
  List<Object?> get props => [];

  SignUpState copyWith({String? failure, bool? isLoading}) {
    return SignUpState(
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

class SignUpPageProvider extends PageProvider<SignUpState> {
  late UserService _user;
  late TextEditingController emailController,
      passwordController,
      firstNameController,
      lastNameController;

  late GlobalKey<FormState> formKey;

  SignUpPageProvider() : super(const SignUpState()) {
    _user = UserService();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  Future<bool> onSignUpPressed() async {
    if (formKey.currentState!.validate()) {
      setProgressDialog('Signing up');
      String response = await _user.register(
        user: UserModel(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        ),
      );

      setProgressDialog(null);

      if (response == "Successfully Registered") {
        showSuccessToast(message: response);

        back();
        return true;
      } else {
        emitFailure(response);
      }
    }

    return false;
  }
}

final signupPageProvider =
    StateNotifierProvider.autoDispose<SignUpPageProvider, SignUpState>(
  (_) => SignUpPageProvider(),
);
