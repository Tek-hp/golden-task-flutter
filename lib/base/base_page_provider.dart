import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:taskapp/base/base_state.dart';

class PageProvider<S extends BaseState> extends StateNotifier<S> {
  void Function(S state)? _listener;
  BuildContext? _context;

  bool _progressDialogInRun = false;

  PageProvider(super.state);

  void emit(BaseState newState) {
    state = newState as S;
    _invokeListener();
  }

  void _invokeListener() {
    _listener?.call(state);
  }

  void emitFailure(String failure, {VoidCallback? onOk}) {
    setProgressDialog(null);
    showToast(failure);
  }

  void setProgressDialog(String? message,
      {bool dismissible = false, BuildContext? context}) {
    if (message == null) {
      if ((context ?? _context) != null && _progressDialogInRun) {
        _progressDialogInRun = false;
        Navigator.pop(context ?? _context!);
      }
    } else {
      if (_context != null) {
        _progressDialogInRun = true;

        // showToast("Please wait, working on it");

        showDialog(
          context: _context!,
          builder: (context) {
            return AlertDialog(
              scrollable: true,
              content: Row(
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  20.horizontalSpace,
                  Text(
                    'Loading, Please wait.',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }

  void showSuccessToast({
    required String message,
  }) {
    setProgressDialog(null);
    showToast(message);
  }

  void showErrorDialog({
    required String title,
    required String message,
    required VoidCallback onOk,
  }) {
    setProgressDialog(null);
    showDialog(
      context: _context!,
      builder: (context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          scrollable: true,
          title: Text(
            "$title : ",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 22.sp,
                  color: Colors.red,
                ),
          ),
          content: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontSize: 22.sp),
          ),
          actions: [
            ElevatedButton(
              onPressed: onOk,
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }

  bool _onReadyCalled = false;

  void go(String routeName, {Object? extra}) {
    if (_context != null) {}
  }

  void replaceWith(String routeName, {Object? extra}) {
    if (_context != null) {
      AutoRouter.of(_context!).pushNamed(routeName);
    }
  }

  void back() {
    if (_context != null) {
      AutoRouter.of(_context!).pop();
    }
  }

  void clearAndGo() {}

  Future supressFailure(Future<void> Function() callback) async {
    try {
      return callback;
    } catch (e) {
      return null;
    }
  }
}

abstract class _BasePage<T extends PageProvider<S>, S extends BaseState>
    extends ConsumerStatefulWidget {
  const _BasePage({
    super.key,
    required this.builder,
    this.onReady,
    this.onDispose,
    this.initState,
    this.listener,
  });

  final ValueChanged<T>? onReady;
  final ValueChanged<T>? initState;
  final VoidCallback? onDispose;
  final Widget Function(BuildContext context, T provider, S state) builder;
  final void Function(BuildContext context, T provider, S state)? listener;
}

class DisposableBasePage<T extends PageProvider<S>, S extends BaseState>
    extends _BasePage<T, S> {
  const DisposableBasePage({
    super.key,
    required this.provider,
    required super.builder,
    super.listener,
    super.onReady,
    super.initState,
    super.onDispose,
  });

  final AutoDisposeStateNotifierProvider<T, S> provider;

  @override
  ConsumerState<DisposableBasePage<T, S>> createState() =>
      _DisposableBasePageState();
}

class _DisposableBasePageState<T extends PageProvider<S>, S extends BaseState>
    extends ConsumerState<DisposableBasePage<T, S>> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _createPageModel();
    });
    super.initState();
  }

  void _createPageModel() {
    final pageProvider = ref.read(widget.provider.notifier);
    pageProvider._listener =
        (state) => widget.listener?.call(context, pageProvider, state);
    pageProvider._context = context;

    if (widget.initState != null) {
      if (pageProvider._onReadyCalled) {
        widget.initState!(pageProvider);
      }
    }

    if (widget.onReady != null) {
      if (!pageProvider._onReadyCalled) {
        widget.onReady!(pageProvider);
        pageProvider._onReadyCalled = true;
      } else {
        widget.onReady!(pageProvider);
      }
    }
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageModel = ref.watch(widget.provider.notifier);
    final pageState = ref.watch(widget.provider);

    return widget.builder(context, pageModel, pageState);
  }
}
