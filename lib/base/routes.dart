import 'package:auto_route/annotations.dart';
import 'package:taskapp/screens/dashboard/dashboard_view.dart';
import 'package:taskapp/screens/dashboard/pages/home/home_view.dart';
import 'package:taskapp/screens/dashboard/pages/settings/settings_view.dart';
import 'package:taskapp/screens/dashboard/pages/splash/splash_view.dart';
import 'package:taskapp/screens/login/login_view.dart';
import 'package:taskapp/screens/signup/sign_up_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,ViewRoute',
  routes: <AutoRoute>[
    AutoRoute(
      page: SplashView,
      initial: true,
    ),
    AutoRoute(
      page: LoginView,
    ),
    AutoRoute(
      page: SignUpView,
    ),
    AutoRoute(
      page: DashboardView,
      children: [
        AutoRoute(page: HomeView),
        AutoRoute(page: SettingView),
      ],
    )
  ],
)
class $AppRouter {}
