import 'package:flutter/material.dart';

import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';

class OneLineDataItem extends StatelessWidget {
  final String title;
  final String content;
  final String actionText;
  final Function()? onActionPressed;
  final Function()? onContentPressed;
  final EdgeInsets? padding;
  final Widget? suffixWidget;

  const OneLineDataItem({
    Key? key,
    required this.title,
    required this.content,
    this.actionText = '',
    this.onActionPressed,
    this.onContentPressed,
    this.padding,
    this.suffixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            vertical: AppConstants.defaultPadding / 2,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: _buildTitleText(
              title: title,
            ),
          ),
          const SizedBox(width: AppConstants.defaultPadding / 2),
          Expanded(
            flex: 6,
            child: _buildContentSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Row(
      children: [
        Expanded(
          child: _buildContentText(
            content: content,
            onContentPressed: onContentPressed,
          ),
        ),
        if (actionText.isNotEmpty) ...[
          const SizedBox(width: AppConstants.defaultPadding / 2),
          _buildActionText(
            actionTitle: actionText,
            onActionPressed: onActionPressed,
          ),
        ],
        if (suffixWidget != null) ...[
          const SizedBox(width: AppConstants.defaultPadding / 2),
          suffixWidget!,
        ]
      ],
    );
  }

  Widget _buildTitleText({
    required String title,
  }) {
    return Text(
      title,
      style: AppTheme.titleTextStyle,
    );
  }

  Widget _buildContentText({
    required String content,
    Function()? onContentPressed,
  }) {
    if (onContentPressed != null) {
      return GestureDetector(
        onTap: onContentPressed,
        child: Text(
          content.isNotEmpty ? content : '-',
          style: AppTheme.bodyTextStyle.copyWith(
            color: AppColors.accentColor,
            decorationColor: AppColors.accentColor,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }
    return Text(
      content.isNotEmpty ? content : '-',
      style: AppTheme.bodyTextStyle,
    );
  }

  Widget _buildActionText({
    required String actionTitle,
    Function()? onActionPressed,
  }) {
    return GestureDetector(
      onTap: onActionPressed,
      child: Text(
        actionTitle,
        style: AppTheme.bodyTextStyle.copyWith(
          color: AppColors.accentColor,
        ),
      ),
    );
  }
}
