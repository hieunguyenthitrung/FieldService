import 'package:field_services/bases/base_state.dart';
import 'package:field_services/utils/routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToSelectLang();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello Splash'),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSelectLang() async {
    await Future.delayed(Duration(seconds: 3));
    navigate(Routes.selectLanguageScreen, isReplace: true);
  }
}
