import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void onLogin() async {
    emit(LoginLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(LoginSuccess());
  }
}
