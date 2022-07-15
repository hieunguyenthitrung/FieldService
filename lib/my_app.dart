import 'package:field_services/app_config/app_config.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/root/root_cubit.dart';
import 'package:field_services/utils/routes.dart';
import 'package:field_services/widgets/initial_bloc_provider.dart';
import 'package:field_services/widgets/initial_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        // Close keyboard when tap outside input zone (textField,...)
        onTap: () =>
            WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
        child: InitialRepositoryProvider(
          baseApi: context.watch<RootCubit>().baseApi,
          child: InitialBlocProvider(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppConfig.instance.flavor.name,
              theme: AppTheme.appTheme,
              onGenerateRoute: Routes.generateRoutes,
              // initialRoute: Routes.splashScreen,
              builder: (ctx, child) {
                return MediaQuery(
                  data: MediaQuery.of(ctx)
                      .copyWith(textScaleFactor: 1.0, boldText: false),
                  child: child!,
                );
              },
            ),
          ),
        ),
      );
  }
}
