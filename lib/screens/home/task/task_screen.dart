import 'dart:async';
import 'dart:io';

import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/screens/home/task/task_cubit.dart';
import 'package:field_services/widgets/di_refresh_indicator.dart';
import 'package:field_services/widgets/items/task_item.dart';
import 'package:field_services/widgets/load_more_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends BaseState<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TaskCubit _taskCubit;
  late TabController _tabController;
  final _scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _taskCubit = BlocProvider.of<TaskCubit>(context);
    _scrollController.addListener(_onScroll);
    _tabController.addListener(_onTabChange);
    _taskCubit.loadTasks();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (ctx, state) {
        if (state is! TaskLoading) {
          _hideRefreshIndicator();
        }
        if (state is TaskLoaded) {
          if (state.isScrollToTop) {
            _scrollToTop();
          }
        }
      },
      builder: (ctx, state) {
        return _buildBody(state);
      },
    );
  }

  Widget _buildBody(TaskState state) {
    final tasks = _taskCubit.tasks;
    final hasReachedMax = _taskCubit.hasReachedMax;
    return Column(
      children: [
        _buildTabBar(),
        const SizedBox(
          height: AppConstants.defaultPadding,
        ),
        if (state is TaskFailed) ...[
          Expanded(
            child: getErrorWidget(
              state.ex,
              onPressed: () => _taskCubit.loadTasks(isShowLoading: true),
            ),
          ),
        ] else if (state is TaskLoading || state is TaskInitial) ...[
          Expanded(
            child: getLoadingWidget(),
          ),
        ] else ...[
          Expanded(
            child: _buildTaskList(tasks, hasReachedMax),
          ),
        ]
      ],
    );
  }

  Widget _buildTaskList(List<int> tasks, bool hasReachedMax) {
    return DiRefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(
          AppConstants.defaultPadding,
        ).copyWith(top: 0),
        controller: _scrollController,
        itemCount:
            hasReachedMax || tasks.isEmpty ? tasks.length : tasks.length + 1,
        itemBuilder: (ctx, index) {
          if (!hasReachedMax && index == tasks.length) {
            return const LoadMoreIndicator();
          }
          return TaskItem(
            onPressed: _onTaskPressed,
          );
        },
        separatorBuilder: (_, __) => Container(
          height: 1,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.defaultPadding,
            vertical: AppConstants.defaultPadding / 2,
          ),
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
        controller: _tabController,
        labelColor: AppColors.primaryColor,
        unselectedLabelColor: AppColors.emperor,
        indicatorColor: AppColors.primaryColor,
        tabs: const [
          Tab(
            text: 'Uncompleted',
          ),
          Tab(
            text: 'Today',
          ),
          Tab(
            text: 'Tomorrow',
          ),
        ]);
  }

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (currentScroll == maxScroll && !_taskCubit.hasReachedMax) {
      _taskCubit.loadTasks(
        isLoadMore: true,
      );
    }
  }

  void _hideRefreshIndicator() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  Future _onRefresh() async {
    _taskCubit.loadTasks(
      isRefresh: true,
    );
    return _refreshCompleter?.future;
  }

  _onTaskPressed() {}

  void _onTabChange() {
    if (_tabController.indexIsChanging) {
      return;
    }

    _taskCubit.loadTasks(
      currentIndex: _tabController.index,
    );
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    },);
  }
}
