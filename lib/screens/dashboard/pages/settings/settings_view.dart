import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/routes.gr.dart';
import 'package:taskapp/base/theme/theme_provider.dart';
import 'package:taskapp/screens/dashboard/pages/settings/settings_viewmodel.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return DisposableBasePage(
      provider: settingsPageProvider,
      builder: (context, provider, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  bool loggedOut = await provider.onLogoutPressed();

                  if (mounted && loggedOut) {
                    AutoRouter.of(context).replaceAll(const [LoginViewRoute()]);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(
                      25.sp,
                    ),
                  ),
                  height: 150.h,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Logout',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final theme = ref.watch(themeModeProvider);

                  return InkWell(
                    onTap: () => provider.onChangeThemePressed(ref, theme),
                    child: Container(
                      margin: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(
                          25.sp,
                        ),
                      ),
                      height: 150.h,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Change Theme',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
