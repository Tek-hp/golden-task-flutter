import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/routes.gr.dart';
import 'package:taskapp/screens/dashboard/pages/splash/splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return DisposableBasePage(
      provider: splashPageProvider,
      onReady: (provider) async {
        bool loggedIn = await provider.onModelReady();

        if (loggedIn && mounted) {
          AutoRouter.of(context).replaceAll(const [DashboardViewRoute()]);
        } else {
          if (mounted) {
            AutoRouter.of(context).replaceAll(const [LoginViewRoute()]);
          }
        }
      },
      builder: (context, provider, state) {
        return const Scaffold(
          body: Center(
            child: Text('Loading...'),
          ),
        );
      },
    );
  }
}
