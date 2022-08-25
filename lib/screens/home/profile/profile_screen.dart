import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/utils/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final items = navigatorItems;
    return Column(
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding:
              const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return _buildRowItem(
              title: items[index],
              onTap: () => _onItemPressed(index),
            );
          },
          separatorBuilder: (_, __) => const Divider(
            height: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildRowItem({
    required String title,
    String? value,
    Widget? trailing,
    Function()? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
      ),
      // textColor: AppColors.neutral3,
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
            ),
          ),
          if (value?.isNotEmpty ?? false) ...{
            const SizedBox(
              width: AppConstants.defaultPadding / 2,
            ),
            Text(
              value!,
              style: AppTheme.bodyTextStyle.copyWith(color: Colors.white),
            ),
          }
        ],
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: AppColors.emperor,
          ),
      onTap: onTap,
    );
  }

  void _onItemPressed(int index) {
    switch (index) {
      case 0:
        navigate(Routes.changePasswordScreen);
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }

  List<String> get navigatorItems => [
        'Change Password',
      ];
}
