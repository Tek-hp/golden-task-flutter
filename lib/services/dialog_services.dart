import 'dart:async';

import 'package:flutter/material.dart';

class DialogService {
  Future show(
    BuildContext context, {
    bool dismissible = true,
    int timeOut = 3,
    Color? barrierColor,
    bool hideShadow = false,
    bool fullPage = false,
    Function? onDone,
    required Widget child,
  }) {
    return showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: dismissible,
        barrierColor: barrierColor ?? Colors.transparent,
        transitionDuration: const Duration(milliseconds: 150),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return fullPage
              ? Material(
                  color: Colors.transparent,
                  child: child,
                )
              : SizedBox(
                  height: 300,
                  width: 300,
                  child: AlertDialog(
                    backgroundColor: hideShadow ? null : Colors.transparent,
                    titlePadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    elevation: hideShadow ? 0 : null,
                    actions: [child],
                  ),
                );
        });

    // return _dialogCompleter!.future;
  }
}
