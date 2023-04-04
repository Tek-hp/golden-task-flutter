import 'package:flutter/material.dart';
import 'package:taskapp/services/dialog_services.dart';

import '../enum/app_state.dart';

class BaseLogic extends ChangeNotifier {
  AppState _currentState = AppState.idle;
  final DialogService _service = DialogService();

  bool get isIdle => _currentState == AppState.idle;
  bool get isError => _currentState == AppState.error;
  bool get isBusy => _currentState == AppState.busy;
  bool get isSuccess => _currentState == AppState.success;

  setIdle() {
    _currentState = AppState.idle;
    notifyListeners();
  }

  setBusy() {
    _currentState = AppState.busy;
    notifyListeners();
  }

  setSuccess() {
    _currentState = AppState.success;
    notifyListeners();
  }

  setError() {
    _currentState = AppState.error;
    notifyListeners();
  }

  showDialogs(
    BuildContext context, {
    required Widget child,
    int timeOut = 5,
    bool dismissible = true,
    bool hideShadow = false,
    bool fullPage = false,
    Color? barrierColor,
    Function? onDone,
  }) =>
      _service.show(context,
          child: child,
          timeOut: timeOut,
          dismissible: dismissible,
          hideShadow: hideShadow,
          fullPage: fullPage,
          barrierColor: barrierColor,
          onDone: onDone);
}
