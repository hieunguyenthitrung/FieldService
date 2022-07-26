import 'package:dio_base_api/exceptions/exceptions.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/constants/string_constant.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/widgets/dialogs/custom_dialog.dart';
import 'package:field_services/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool _isShowingLoadingDialog = false;
  bool _isShowingDialog = false;

  void showLoadingDialog({String text = ''}) {
    if (_isShowingLoadingDialog) {
      return;
    }
    _isShowingLoadingDialog = true;
    unFocus();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return const LoadingDialog();
      },
    );
  }

  Future showConfirmDialog({
    required String message,
    String title = Strings.confirm,
    String? okText,
    String? closeText,
    Function? onOkPressed,
    Function? onClosePressed,
    bool bearerDismissible = true,
  }) async {
    hideLoadingDialog();
    hideDialog();
    _isShowingDialog = true;
    final result = await showDialog(
      context: context,
      barrierDismissible: bearerDismissible,
      builder: (ctx) {
        return CustomDialog(
          CustomDialogType.confirm,
          title,
          message,
          okText: okText,
          closeText: closeText,
          okTextColor: Colors.white,
          onOkPressed: () {
            if (onOkPressed != null) {
              onOkPressed();
              return;
            }
            Navigator.of(ctx, rootNavigator: true).pop();
          },
          onClosePressed: () {
            if (onClosePressed != null) {
              onClosePressed();
              return;
            }
            Navigator.of(ctx, rootNavigator: true).pop();
          },
        );
      },
    );
    _isShowingDialog = false;
    return result;
  }

  Future showInformDialog({
    required String message,
    String title = Strings.notice,
    String? btnText,
    Function? onClosePressed,
    bool bearerDismissible = true,
  }) async {
    hideLoadingDialog();
    hideDialog();
    _isShowingDialog = true;
    final result = await showDialog(
      context: context,
      barrierDismissible: bearerDismissible,
      builder: (ctx) {
        return CustomDialog(
          CustomDialogType.inform,
          title,
          message,
          closeText: btnText,
          onClosePressed: () {
            if (onClosePressed != null) {
              onClosePressed();
              Navigator.of(ctx, rootNavigator: true).pop();
              return;
            }
            Navigator.of(ctx, rootNavigator: true).pop();
          },
        );
      },
    );
    _isShowingDialog = false;
    return result;
  }

  void hideDialog() {
    unFocus();
    if (_isShowingDialog) {
      _isShowingDialog = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void hideLoadingDialog() {
    unFocus();
    if (_isShowingLoadingDialog) {
      _isShowingLoadingDialog = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Widget getLoadingWidget() {
    return const Center(
      child: SpinKitFadingCircle(
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget getErrorWidget(
    exception, {
    String? unknownError,
    String? btnText,
    onPressed,
  }) {
    final msg = getErrorMsg(
      exception,
      msg: unknownError,
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding,
            ),
            child: Text(
              msg,
              style: AppTheme.titleTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          if (onPressed != null) ...[
            const SizedBox(height: AppConstants.defaultPadding),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                ),
                onPressed: onPressed,
                child: Text(btnText ?? Strings.tryAgain),
              ),
            ),
          ]
        ],
      ),
    );
  }

  void unFocus() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  Future navigate(
    String name, {
    dynamic args,
    bool isReplace = false,
  }) async {
    if (isReplace) {
      return Navigator.pushReplacementNamed(
        context,
        name,
        arguments: args,
      );
    }
    return Navigator.pushNamed(
      context,
      name,
      arguments: args,
    );
  }

  Future pushAndRemoveUtil(
    String name,
    bool Function(Route<dynamic> route) predicate, {
    dynamic args,
  }) {
    Navigator.popUntil(context, predicate);
    return Navigator.pushReplacementNamed(
      context,
      name,
      arguments: args,
    );

    ///Navigator.pushAndRemoveUtil isn't working because this is a bug from flutter
    ///https://github.com/Flutterando/modular/issues/615
    // return Navigator.pushNamedAndRemoveUntil(
    //   context,
    //   name,
    //   predicate,
    //   arguments: args,
    // );
  }

  void popUntil(bool Function(Route<dynamic> route) predicate) {
    Navigator.popUntil(context, predicate);
  }

  /// get error message from exception
  /// example:
  /// if(state is LoginFailed) {
  ///   String msg = getErrorMsg(state.ex);
  /// }
  String getErrorMsg(dynamic ex, {String? msg}) {
    if (ex is ServerException) {
      var err = ex.error?.toString() ?? '';
      if (err.isEmpty) {
        err = Strings.anErrorOccurred;
      }
      return err;
    }
    if (ex is ManuallyException) {
      return ex.message;
    }
    if (ex is ConnectionException) {
      return Strings.connectionFailed;
    }
    if (ex is Error) {
      return Strings.anErrorOccurred;
    }
    return msg ?? Strings.anErrorOccurred;
  }

  showSnackBar(String message, {SnackBarType type = SnackBarType.success}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        backgroundColor: type.snackBarColor,
        content: Text(
          message,
          style: AppTheme.bodyTextStyle,
        ),
      ),
    );
  }
}

enum SnackBarType {
  success,
  failure,
}

extension SnackBarTypeEx on SnackBarType {
  Color get snackBarColor {
    switch (this) {
      case SnackBarType.success:
        return AppColors.eucalyptus;
      case SnackBarType.failure:
        return AppColors.redOrange;
    }
  }
}
