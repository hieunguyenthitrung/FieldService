import 'package:field_services/resources/app_colors.dart';
import 'package:flutter/material.dart';

class DiRefreshIndicator extends StatelessWidget {
  const DiRefreshIndicator(
      {required this.child, required this.onRefresh, key})
      : super(key: key);
  final Widget child;
  final Future<void> Function() onRefresh;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.white,
      backgroundColor: AppColors.primaryColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
