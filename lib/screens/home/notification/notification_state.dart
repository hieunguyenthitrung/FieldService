part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final bool isScrollToTop;

  NotificationLoaded({this.isScrollToTop = false});
}

class NotificationLoading extends NotificationState {}

class NotificationFailed extends NotificationState {
  final dynamic ex;

  NotificationFailed(this.ex);
}
