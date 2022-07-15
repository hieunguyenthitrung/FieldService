import 'package:field_services/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialBlocProvider extends StatelessWidget {
  final Widget child;

  const InitialBlocProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => HomeCubit(),
        ),
      ],
      child: child,
    );
  }
}
