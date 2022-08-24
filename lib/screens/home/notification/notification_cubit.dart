import 'package:field_services/data/models/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  int _page = 1;
  int _currentIndex = 0;
  bool _hasReachedMax = false;
  final _notifications = <Notification>[];

  void loadNotifications({
    int currentIndex = 0,
    bool isRefresh = false,
    bool isLoadMore = false,
    bool isShowLoading = false,
  }) async {
    try {
      if (isShowLoading) {
        emit(NotificationLoading());
      }
      if (isLoadMore) {
        _page++;
      }
      if (isRefresh || _currentIndex != currentIndex) {
        _page = 1;
        _hasReachedMax = false;
        if (_currentIndex != currentIndex && !isLoadMore) {
          _currentIndex = currentIndex;
          isRefresh = true;
          emit(NotificationLoading());
        }
      }

      // final request = PagingRequest(page: _page);
      // final token = await StorageUtil.getToken();
      // final res = await taskRepository.tasks(request, token);
      // if (res.error != null) {
      //   emit(
      //     NotificationFailed(
      //       ServerException(
      //         res.error!.message,
      //       ),
      //     ),
      //   );
      //   return;
      // }
      await Future.delayed(const Duration(seconds: 1));
      if (isRefresh) {
        _notifications.clear();
      }
      _notifications.addAll(
        List.generate(
          10,
          (index) => Notification.genTestData(),
        ),
      );
      // final total = res.result!.total;
      final total = 30;
      _hasReachedMax = _notifications.length >= total;
      emit(NotificationLoaded(isScrollToTop: isRefresh));
    } catch (ex) {
      emit(NotificationFailed(ex));
    }
  }

  void readNotification(int index) {
    _notifications[index].isRead = true;
    emit(NotificationLoaded());
  }

  void readAllNotifications() {
    for (final item in _notifications) {
      if (item.isRead) continue;
      item.isRead = true;
    }
    emit(NotificationLoaded());
  }

  void refreshUI() {
    emit(NotificationLoaded());
  }

  int get page => _page;
  bool get hasReachedMax => _hasReachedMax;
  List<Notification> get notifications => _notifications;
}
