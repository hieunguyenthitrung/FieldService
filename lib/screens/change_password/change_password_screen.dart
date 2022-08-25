import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/data/requests/change_password_request.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/screens/change_password/change_password_cubit.dart';
import 'package:field_services/utils/routes.dart';
import 'package:field_services/widgets/app_bar/app_bar_middle_text.dart';
import 'package:field_services/widgets/di_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends BaseState<ChangePasswordScreen> {
  late ChangePasswordCubit _changePasswordCubit;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    _changePasswordCubit = BlocProvider.of<ChangePasswordCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _changePasswordCubit.close();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildCubit(),
    );
  }

  Widget _buildCubit() {
    return KeyboardVisibilityBuilder(
      builder: (ctx, isKeyboardVisible) {
        return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (ctx, state) {
            if (state is ChangePasswordLoading) {
              showLoadingDialog();
              return;
            }
            hideLoadingDialog();
            if (state is ChangePasswordSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (ctx, state) {
            return _buildBody(isKeyboardVisible);
          },
        );
      },
    );
  }

  Widget _buildBody(bool isKeyboardVisible) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(
                  controller: _currentPasswordController,
                  hintText: 'Current Password',
                  obscureText: true,
                ),
                _buildTextField(
                  controller: _newPasswordController,
                  hintText: 'New Password',
                  obscureText: true,
                ),
                _buildTextField(
                  controller: _confirmNewPasswordController,
                  hintText: 'Confirm New Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: AppConstants.defaultPadding * 2,
                ),
                DiPrimaryButton(
                  width: MediaQuery.of(context).size.width * 0.75,
                  label: 'Confirm',
                  onPressed: _onChangePasswordPressed,
                ),
                const SizedBox(
                  height: AppConstants.defaultPadding,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    TextInputType? inputType,
    bool? obscureText,
  }) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

  _onChangePasswordPressed() {
    final req = ChangePasswordRequest(
      currentPassword: _currentPasswordController.text,
      newPassword: _newPasswordController.text,
      confirmNewPassword: _confirmNewPasswordController.text,
    );

    final msg = req.validate;
    if (msg.isNotEmpty) {
      showSnackBar(msg, type: SnackBarType.failure);
      return;
    }
    _changePasswordCubit.onChangePassword();
  }

  _buildAppBar() {
    return AppBarMiddleText(
      title: 'Change Password',
      isShowShadow: true,
    );
  }
}
