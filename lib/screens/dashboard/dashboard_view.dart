import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/routes.gr.dart';
import 'package:taskapp/screens/dashboard/dashboard_viewmodel.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return DisposableBasePage(
      provider: dashboardPageProvider,
      builder: (context, provider, state) {
        return AutoTabsScaffold(
          appBarBuilder: (context, tabsRouter) {
            return AppBar(
              title: Text(
                tabsRouter.activeIndex == 0 ? "Home" : "Settings",
              ),
            );
          },
          routes: const [
            HomeViewRoute(),
            SettingViewRoute(),
          ],
          bottomNavigationBuilder: (context, tabsRouter) {
            return BottomNavigationBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                    ),
                    activeIcon: Icon(
                      Icons.home_outlined,
                      color: Colors.orange,
                    ),
                    label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: Colors.black,
                  ),
                  activeIcon: Icon(
                    Icons.settings_outlined,
                    color: Colors.orange,
                  ),
                  label: "Settings",
                ),
              ],
            );
          },
        );
      },
    );
  }
}
