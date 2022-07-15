import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/screens/login/login_cubit.dart';
import 'package:field_services/utils/routes.dart';
import 'package:field_services/widgets/di_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  late LoginCubit _loginCubit;
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    _loginCubit = BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _loginCubit.close();
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
        return BlocConsumer<LoginCubit, LoginState>(
          listener: (ctx, state) {
            if (state is LoginLoading) {
              showLoadingDialog();
              return;
            }
            hideLoadingDialog();
            if (state is LoginSuccess) {
              navigate(Routes.homeScreen, isReplace: true);
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
                  label: 'Login',
                  onPressed: _onLoginPressed,
                ),
                const SizedBox(
                  height: AppConstants.defaultPadding,
                ),
                GestureDetector(
                  onTap: () => navigate(
                    Routes.selectLanguageScreen,
                    isReplace: true,
                  ),
                  child: Text(
                    'Back to select language',
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

  _onLoginPressed() {
    _loginCubit.onLogin();
  }
}
