import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/routes.gr.dart';
import 'package:taskapp/base/utilities/validator.dart';
import 'package:taskapp/base/widgets/custom_text_field.dart';
import 'package:taskapp/screens/signup/sign_up_viewmodel.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return DisposableBasePage(
      provider: signupPageProvider,
      builder: (context, provider, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Sign Up"),
          ),
          body: Container(
            constraints: const BoxConstraints.expand(),
            child: SafeArea(
              child: Form(
                key: provider.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: CustomTextField(
                        labelText: 'First Name',
                        textController: provider.firstNameController,
                        validator: Validator.nameValidator,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: CustomTextField(
                        labelText: 'Last Name',
                        textController: provider.lastNameController,
                        validator: Validator.nameValidator,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: CustomTextField(
                        labelText: 'Email',
                        textController: provider.emailController,
                        validator: Validator.emailValidator,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: CustomTextField(
                        labelText: 'Password',
                        textController: provider.passwordController,
                        obscureText: true,
                        validator: Validator.passwordValidator,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      ),
                      onPressed: () async {
                        bool signupSuccess = await provider.onSignUpPressed();

                        if (signupSuccess) {
                          if (mounted) {
                            AutoRouter.of(context)
                                .replaceAll(const [DashboardViewRoute()]);
                          }
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 50.0,
                        ),
                        child: Text('Sign up'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
