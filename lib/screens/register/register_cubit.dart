import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void onRegister() async {
    emit(RegisterLoading());
    await Future.delayed(Duration(seconds: 1));
    emit(RegisterSuccess());
  }
}
