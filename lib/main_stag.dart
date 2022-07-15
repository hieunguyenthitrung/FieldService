import 'package:field_services/app_config/app_config.dart';
import 'package:field_services/bloc_delegate/simple_bloc_observer.dart';
import 'package:field_services/my_app.dart';
import 'package:field_services/root/root_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await setConfig(Flavor.production);
  BlocOverrides.runZoned(
    () => runApp(
      BlocProvider(
        create: (context) => RootCubit(),
        child: BlocBuilder<RootCubit, RootState>(
          builder: (ctx, state) {
            return const MyApp();
          },
        ),
      ),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

