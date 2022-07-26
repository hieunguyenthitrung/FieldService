import 'package:dio_base_api/exceptions/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  int _page = 1;
  int _currentIndex = 0;
  bool _hasReachedMax = false;
  final _tasks = <int>[];

  void loadTasks({
    int currentIndex = 0,
    bool isRefresh = false,
    bool isLoadMore = false,
    bool isShowLoading = false,
  }) async {
    try {
      if (isShowLoading) {
        emit(TaskLoading());
      }
      if (isLoadMore) {
        _page++;
      }
      if (isRefresh || _currentIndex != currentIndex) {
        _page = 1;
        _hasReachedMax = false;
        if (_currentIndex != currentIndex) {
          _currentIndex = currentIndex;
          isRefresh = true;
          emit(TaskLoading());
        }
      }

      // final request = PagingRequest(page: _page);
      // final token = await StorageUtil.getToken();
      // final res = await taskRepository.tasks(request, token);
      // if (res.error != null) {
      //   emit(
      //     TaskFailed(
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
      emit(TaskLoaded(isScrollToTop: isRefresh));
    } catch (ex) {
      emit(TaskFailed(ex));
    }
  }

  void refreshUI() {
    emit(TaskLoaded());
  }

  int get page => _page;
  bool get hasReachedMax => _hasReachedMax;
  List<int> get tasks => _tasks;
}
