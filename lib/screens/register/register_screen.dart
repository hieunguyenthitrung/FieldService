import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/screens/register/register_cubit.dart';
import 'package:field_services/utils/routes.dart';
import 'package:field_services/widgets/di_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen> {
  late RegisterCubit _registerCubit;
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _registerCubit = BlocProvider.of<RegisterCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _registerCubit.close();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCubit(),
    );
  }

  Widget _buildCubit() {
    return KeyboardVisibilityBuilder(
      builder: (ctx, isKeyboardVisible) {
        return BlocConsumer<RegisterCubit, RegisterState>(
          listener: (ctx, state) {
            if (state is RegisterLoading) {
              showLoadingDialog();
              return;
            }
            hideLoadingDialog();
            if (state is RegisterSuccess) {
              pushAndRemoveUtil(Routes.homeScreen, (route) => route.isFirst);
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
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: isKeyboardVisible
              ? MediaQuery.of(context).size.height * 0.2
              : MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: Center(
            child: Text(
              'Di Field Services',
              style: AppTheme.headerTextStyle.copyWith(fontSize: 22),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                _buildTextField(
                  controller: _userNameController,
                  hintText: 'UserName',
                ),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: AppConstants.defaultPadding * 2,
                ),
                DiPrimaryButton(
                  width: MediaQuery.of(context).size.width * 0.75,
                  label: 'Register',
                  onPressed: _onRegisterPressed,
                ),
                const SizedBox(
                  height: AppConstants.defaultPadding,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Back to login',
                    style: AppTheme.bodyTextStyle.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.primaryColor,
                    ),
                  ),
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

  _onRegisterPressed() {
    _registerCubit.onRegister();
  }
}
