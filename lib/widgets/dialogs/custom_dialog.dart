
import 'package:field_services/constants/string_constant.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:flutter/material.dart';

enum CustomDialogType {
  confirm,
  inform,
}

class CustomDialog extends StatelessWidget {
  const CustomDialog(
    this.type,
    this.title,
    this.message, {
    Key? key,
    this.okText = Strings.ok,
    this.closeText = Strings.close,
    this.okBgColor,
    this.okTextColor,
    this.closeBgColor,
    this.closeTextColor,
    this.onOkPressed,
    this.onClosePressed,
  }) : super(key: key);

  final CustomDialogType type;
  final String title;
  final String message;
  final String? okText;
  final String? closeText;
  final Color? okBgColor;
  final Color? closeBgColor;
  final Color? okTextColor;
  final Color? closeTextColor;
  final Function? onOkPressed;
  final Function? onClosePressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBody(),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            _buildButtonSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTheme.titleTextStyle,
            ),
            const SizedBox(height: 16),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: SingleChildScrollView(
                child: Text(
                  message,
                  style: AppTheme.bodyTextStyle.copyWith(height: 1.4),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  Widget _buildButtonSection() {
    if (type == CustomDialogType.inform) {
      return Row(
        children: [
          Expanded(
            child: _buildButton(
              closeText ?? Strings.close,
              closeBgColor,
              closeTextColor,
              onClosePressed,
            ),
          ),
        ],
      );
    }
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            okText ?? Strings.ok,
            okBgColor,
            okTextColor,
            onOkPressed,
          ),
        ),
        Container(
          height: 32,
          width: 1,
          color: AppColors.silver,
        ),
        Expanded(
          child: _buildButton(
            closeText ?? Strings.close,
            closeBgColor,
            closeTextColor,
            onClosePressed,
          ),
        )
      ],
    );
  }

  Widget _buildButton(
      String? text, Color? bgColor, Color? textColor, Function? onPressed) {
    return Builder(builder: (context) {
      return Material(
        color: bgColor,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: AppTheme.buttonTextStyle.copyWith(
                color: textColor,
              ),
            ),
          ),
          onTap: () {
            if (onPressed != null) {
              onPressed();
              return;
            }
          },
        ),
      );
    });
  }
}
