

import 'package:field_services/utils/app_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    AppUtil.printLogDevOnly('${bloc.runtimeType} Event $event');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    AppUtil.printLogDevOnly('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppUtil.printLogDevOnly('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    AppUtil.printLogDevOnly('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }
}
