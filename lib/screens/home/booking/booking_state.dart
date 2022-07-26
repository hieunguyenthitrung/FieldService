part of 'booking_cubit.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoaded extends BookingState {
  final bool isScrollToTop;
  BookingLoaded({this.isScrollToTop = false});
}

class BookingLoading extends BookingState {}

class BookingFailed extends BookingState {
  final dynamic ex;

  BookingFailed(this.ex);
}
