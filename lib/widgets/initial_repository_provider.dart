import 'package:dio_base_api/dio_base_api.dart';
import 'package:field_services/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialRepositoryProvider extends StatelessWidget {
  final DioBaseApi baseApi;
  final Widget child;

  const InitialRepositoryProvider({
    Key? key,
    required this.baseApi,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (ctx) => UserRepository(baseApi),
        ),
      ],
      child: child,
    );
  }
}
