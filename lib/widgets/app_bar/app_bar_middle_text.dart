import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:flutter/material.dart';

class AppBarMiddleText extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leadWidget;
  final List<Widget>? actionWidgets;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isBackNavigation;
  final bool isShowShadow;
  final bool isBorderBottom;
  final bool ignoreTestBanner;
  final Function? onBack;
  final bool automaticallyImplyLeading;

  const AppBarMiddleText(
      {Key? key,
      this.title = '',
      this.leadWidget,
      this.actionWidgets,
      this.backgroundColor,
      this.textColor,
      this.isBackNavigation = true,
      this.isShowShadow = false,
      this.isBorderBottom = true,
      this.ignoreTestBanner = false,
      this.onBack,
      this.automaticallyImplyLeading = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildAppBar(),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: _buildAppTitle(),
      leading: _buildLeadButton(),
      automaticallyImplyLeading: automaticallyImplyLeading,
      actions: actionWidgets,
      centerTitle: true,
      elevation: isShowShadow ? 6 : 0,
      backgroundColor: backgroundColor ?? AppColors.primaryColor,
    );
  }

  Widget _buildAppTitle() {
    return Text(
      title,
      style:
          AppTheme.headerTextStyle.copyWith(color: textColor ?? Colors.white),
    );
  }

  Widget? _buildLeadButton() {
    if (isBackNavigation) {
      return Builder(builder: (context) {
        return IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            if (onBack != null) {
              onBack!();
            } else {
              Navigator.pop(context);
            }
          },
        );
      });
    }
    return leadWidget;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
