// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../screens/dashboard/dashboard_view.dart' as _i4;
import '../screens/dashboard/pages/home/home_view.dart' as _i5;
import '../screens/dashboard/pages/settings/settings_view.dart' as _i6;
import '../screens/dashboard/pages/splash/splash_view.dart' as _i1;
import '../screens/login/login_view.dart' as _i2;
import '../screens/signup/sign_up_view.dart' as _i3;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashViewRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashView(),
      );
    },
    LoginViewRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginView(),
      );
    },
    SignUpViewRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.SignUpView(),
      );
    },
    DashboardViewRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.DashboardView(),
      );
    },
    HomeViewRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.HomeView(),
      );
    },
    SettingViewRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.SettingView(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          SplashViewRoute.name,
          path: '/',
        ),
        _i7.RouteConfig(
          LoginViewRoute.name,
          path: '/login-view',
        ),
        _i7.RouteConfig(
          SignUpViewRoute.name,
          path: '/sign-up-view',
        ),
        _i7.RouteConfig(
          DashboardViewRoute.name,
          path: '/dashboard-view',
          children: [
            _i7.RouteConfig(
              HomeViewRoute.name,
              path: 'home-view',
              parent: DashboardViewRoute.name,
            ),
            _i7.RouteConfig(
              SettingViewRoute.name,
              path: 'setting-view',
              parent: DashboardViewRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashView]
class SplashViewRoute extends _i7.PageRouteInfo<void> {
  const SplashViewRoute()
      : super(
          SplashViewRoute.name,
          path: '/',
        );

  static const String name = 'SplashViewRoute';
}

/// generated route for
/// [_i2.LoginView]
class LoginViewRoute extends _i7.PageRouteInfo<void> {
  const LoginViewRoute()
      : super(
          LoginViewRoute.name,
          path: '/login-view',
        );

  static const String name = 'LoginViewRoute';
}

/// generated route for
/// [_i3.SignUpView]
class SignUpViewRoute extends _i7.PageRouteInfo<void> {
  const SignUpViewRoute()
      : super(
          SignUpViewRoute.name,
          path: '/sign-up-view',
        );

  static const String name = 'SignUpViewRoute';
}

/// generated route for
/// [_i4.DashboardView]
class DashboardViewRoute extends _i7.PageRouteInfo<void> {
  const DashboardViewRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DashboardViewRoute.name,
          path: '/dashboard-view',
          initialChildren: children,
        );

  static const String name = 'DashboardViewRoute';
}

/// generated route for
/// [_i5.HomeView]
class HomeViewRoute extends _i7.PageRouteInfo<void> {
  const HomeViewRoute()
      : super(
          HomeViewRoute.name,
          path: 'home-view',
        );

  static const String name = 'HomeViewRoute';
}

/// generated route for
/// [_i6.SettingView]
class SettingViewRoute extends _i7.PageRouteInfo<void> {
  const SettingViewRoute()
      : super(
          SettingViewRoute.name,
          path: 'setting-view',
        );

  static const String name = 'SettingViewRoute';
}
