import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());


  int _page = 1;
  bool _hasReachedMax = false;
  final _tasks = <int>[];

  void loadBookings({
    required DateTime selectedDate,
    bool isRefresh = false,
    bool isLoadMore = false,
    bool isShowLoading = false,
  }) async {
    try {
      if (isShowLoading) {
        emit(BookingLoading());
      }
      if (isLoadMore) {
        _page++;
      }
      if (isRefresh) {
        _page = 1;
        _hasReachedMax = false;
        emit(BookingLoading());
      }

      // final request = PagingRequest(page: _page);
      // final token = await StorageUtil.getToken();
      // final res = await taskRepository.tasks(request, token);
      // if (res.error != null) {
      //   emit(
      //     BookingFailed(
      //       ServerException(
      //         res.error!.message,
      //       ),
      //     ),
      //   );
      //   return;
      // }
      await Future.delayed(const Duration(seconds: 1));
      if (isRefresh) {
        _tasks.clear();
      }
      _tasks.addAll(
        [for (var i = _tasks.length; i < _tasks.length + 10; i++) i],
      );
      // final total = res.result!.total;
      final total = 30;
      _hasReachedMax = _tasks.length >= total;
      emit(BookingLoaded(isScrollToTop: isRefresh));
    } catch (ex) {
      emit(BookingFailed(ex));
    }
  }

  void refreshUI() {
    emit(BookingLoaded());
  }

  int get page => _page;
  bool get hasReachedMax => _hasReachedMax;
  List<int> get tasks => _tasks;


}
