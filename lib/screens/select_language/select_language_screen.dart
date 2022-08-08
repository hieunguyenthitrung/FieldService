import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/screens/select_language/select_language_cubit.dart';
import 'package:field_services/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends BaseState<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    return BlocConsumer<SelectLanguageCubit, SelectLanguageState>(
      listener: (context, state) {},
      builder: (context, state) {
        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedTextKit(
              pause: Duration.zero,
              repeatForever: true,
              animatedTexts: [
                _buildAnimatedHeaderText('Chọn Ngôn Ngữ'),
                _buildAnimatedHeaderText('Select Language'),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lang.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(
                  lang[index],
                  textAlign: TextAlign.center,
                ),
                onTap: _onLanguagePressed,
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  RotateAnimatedText _buildAnimatedHeaderText(String text) {
    return RotateAnimatedText(
      text,
      textStyle: AppTheme.titleTextStyle,
      duration: const Duration(seconds: 3),
    );
  }

  List<String> get lang => <String>['English', 'Tiếng Việt'];

  void _onLanguagePressed() {
    navigate(Routes.loginScreen, isReplace: true);
  }
}
