import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taskapp/base/routes.gr.dart';
import 'package:taskapp/base/theme/color_schemes.dart';
import 'package:taskapp/base/theme/typograpgy.dart';

import 'base/theme/theme_provider.dart';

class RemoteCoach extends ConsumerWidget {
  RemoteCoach({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return RefreshConfiguration(
      dragSpeedRatio: 0.91,
      headerBuilder: () => const MaterialClassicHeader(),
      enableLoadingWhenNoData: false,
      child: ScreenUtilInit(
        designSize: const Size(540, 1200),
        builder: (context, child) => OKToast(
          position: ToastPosition.bottom,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Remote Coach Application',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(centerTitle: true),
              colorScheme: lightColorScheme,
              textTheme: textTheme,
            ),
            darkTheme: ThemeData(
              appBarTheme: const AppBarTheme(centerTitle: true),
              colorScheme: darkColorScheme,
              textTheme: textTheme,
            ),
            themeMode: themeMode,
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          ),
        ),
      ),
    );
  }
}
