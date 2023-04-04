import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/routes.gr.dart';
import 'package:taskapp/base/utilities/validator.dart';
import 'package:taskapp/base/widgets/custom_text_field.dart';
import 'package:taskapp/screens/login/login_viewlogic.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return DisposableBasePage(
      provider: loginPageProvider,
      builder: (context, provider, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Login"),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account yet? ",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushRoute(const SignUpViewRoute());
                              },
                              child: Text(
                                "Register Now",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                              fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: () async {
                          bool loginSuccess = await provider.onLoginPressed();

                          if (loginSuccess) {
                            if (mounted) {
                              context.router
                                  .replaceAll(const [DashboardViewRoute()]);
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 50.0,
                          ),
                          child: Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
