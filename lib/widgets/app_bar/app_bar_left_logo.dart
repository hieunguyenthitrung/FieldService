
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/utils/image_util.dart';
import 'package:flutter/material.dart';

class AppBarLeftLogo extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final bool isShowShadow;
  final Function? onLogoPressed;

  const AppBarLeftLogo({
    Key? key,
    this.actions,
    this.isShowShadow = false,
    this.onLogoPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildLogo(),
      backgroundColor: AppColors.primaryColor,
      centerTitle: false,
      actions: actions,
      automaticallyImplyLeading: false,
      elevation: isShowShadow ? 1 : 0,
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: onLogoPressed != null ? () => onLogoPressed!() : null,
      child: ImageUtil.loadAssetsImage(
        assetPath: '',
        fit: BoxFit.contain,
        height: 45,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
