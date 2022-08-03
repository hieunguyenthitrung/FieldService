import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'booking_detail_state.dart';

class BookingDetailCubit extends Cubit<BookingDetailState> {
  BookingDetailCubit() : super(BookingDetailInitial());
}
