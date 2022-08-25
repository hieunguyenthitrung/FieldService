import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  void onChangePassword() async {
    emit(ChangePasswordLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(ChangePasswordSuccess());
  }
}
