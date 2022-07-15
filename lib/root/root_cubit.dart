import 'package:dio_base_api/dio_base_api.dart';
import 'package:field_services/app_config/app_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';


part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit() : super(RootInitial());

  final _baseApi = DioBaseApi(
    baseUrl: AppConfig.instance.flavor.flavorValues.baseUrl,
    isProductEnv:
        AppConfig.instance.flavor == Flavor.production && kReleaseMode,
  );


  DioBaseApi get baseApi => _baseApi;

}
