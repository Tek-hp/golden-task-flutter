import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/screens/dashboard/pages/home/home_viewmodel.dart';
import 'package:taskapp/screens/dashboard/pages/home/widgets/gold_tile.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DisposableBasePage(
      provider: homePageProvider,
      onReady: (provider) => provider.getMetalData(),
      builder: (context, provider, state) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SmartRefresher(
                  controller: provider.refreshController,
                  enablePullDown: true,
                  header: const WaterDropHeader(),
                  onRefresh: () => provider.onRefresh(),
                  child: state.goldObjects != null
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.goldObjects!.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return 10.verticalSpace;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return GoldTile(
                              gold: state.goldObjects![index],
                            );
                          },
                        )
                      : const Center(
                          child: Text("Getting data..."),
                        ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
