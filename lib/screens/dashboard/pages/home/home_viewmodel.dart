import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taskapp/base/base_page_provider.dart';
import 'package:taskapp/base/base_state.dart';
import 'package:taskapp/models/gold_model.dart';
import 'package:taskapp/services/gold_service.dart';

class HomeState extends BaseState<HomeState> {
  const HomeState({
    bool isLoading = false,
    String? failure,
    this.goldObjects,
  }) : super(isLoading, failure);

  final List<GoldResponse>? goldObjects;

  @override
  List<Object?> get props => [];

  HomeState copyWith(
      {String? failure, bool? isLoading, List<GoldResponse>? goldObjects}) {
    return HomeState(
      failure: failure ?? this.failure,
      isLoading: isLoading ?? this.isLoading,
      goldObjects: goldObjects ?? this.goldObjects,
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

class HomePageProvider extends PageProvider<HomeState> {
  late MetalService _metalService;
  late RefreshController refreshController;
  HomePageProvider() : super(const HomeState()) {
    _metalService = MetalService();
    refreshController = RefreshController();
  }

  getMetalData() async {
    GoldResponse? gold = await _metalService.getGoldData();

    if (gold == null) {
      showToast('error getting data');
    } else {
      List<GoldResponse> goldObjects = state.goldObjects ?? [];
      goldObjects.insert(0, gold);

      emit(state.copyWith(goldObjects: goldObjects));
    }
  }

  onRefresh() async {
    await getMetalData();
    refreshController.refreshCompleted();
  }
}

final homePageProvider =
    StateNotifierProvider.autoDispose<HomePageProvider, HomeState>(
  (_) => HomePageProvider(),
);
