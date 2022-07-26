part of 'task_cubit.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final bool isScrollToTop;

  TaskLoaded({this.isScrollToTop = false});
}

class TaskLoading extends TaskState {}

class TaskFailed extends TaskState {
  final dynamic ex;
  
  TaskFailed(this.ex);
}
