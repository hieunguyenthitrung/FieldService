
import 'package:field_services/utils/image_util.dart';
import 'package:flutter/material.dart';

class AppBarMiddleLogo extends StatelessWidget implements PreferredSizeWidget {
  final bool isShowCloseBtn;
  final Function? onCloseBtnPressed;

  const AppBarMiddleLogo({
    Key? key,
    this.isShowCloseBtn = false,
    this.onCloseBtnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: _buildLogo(),
        ),
        Positioned(
          top: 0,
          left: 16,
          bottom: 0,
          child: _buildCloseIcon(),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return ImageUtil.loadAssetsImage(
      assetPath: '',
      fit: BoxFit.contain,
      height: 45,
    );
  }

  Widget _buildCloseIcon() {
    return Builder(
      builder: (ctx) {
        return GestureDetector(
          onTap: () => _onClosePressed(ctx),
          child: const Icon(
            Icons.chevron_left,
            size: 24,
          ),
        );
      },
    );
  }

  void _onClosePressed(BuildContext context) {
    if (onCloseBtnPressed != null) {
      onCloseBtnPressed!();
      return;
    }

    Navigator.pop(context);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
