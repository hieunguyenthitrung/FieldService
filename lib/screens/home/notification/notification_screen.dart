import 'dart:async';

import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/screens/home/notification/notification_cubit.dart';
import 'package:field_services/widgets/app_bar/app_bar_middle_text.dart';
import 'package:field_services/widgets/di_refresh_indicator.dart';
import 'package:field_services/widgets/items/notification_item.dart';
import 'package:field_services/widgets/load_more_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:field_services/data/models/notification.dart' as n;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends BaseState<NotificationScreen> {
  late NotificationCubit _notificationCubit;
  final _scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    _notificationCubit = BlocProvider.of<NotificationCubit>(context);
    _scrollController.addListener(_onScroll);
    _notificationCubit.loadNotifications();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMiddleText(
        title: 'Notification',
        isShowShadow: true,
        actionWidgets: [
          _buildReadAllButton(),
        ],
      ),
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (ctx, state) {
        if (state is! NotificationLoading) {
          _hideRefreshIndicator();
        }
        if (state is NotificationLoaded) {}
      },
      builder: (ctx, state) {
        return _buildBody(state);
      },
    );
  }

  Widget _buildBody(NotificationState state) {
    final notifications = _notificationCubit.notifications;
    final hasReachedMax = _notificationCubit.hasReachedMax;
    return Column(
      children: [
        if (state is NotificationFailed) ...[
          Expanded(
            child: getErrorWidget(
              state.ex,
              onPressed: () => _notificationCubit.loadNotifications(
                isShowLoading: true,
              ),
            ),
          ),
        ] else if (state is NotificationLoading ||
            state is NotificationInitial) ...[
          Expanded(
            child: getLoadingWidget(),
          ),
        ] else ...[
          Expanded(
            child: _buildNotificationList(notifications, hasReachedMax),
          ),
        ]
      ],
    );
  }

  Widget _buildNotificationList(
    List<n.Notification> notifications,
    bool hasReachedMax,
  ) {
    return DiRefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        physics: const AlwaysScrollableScrollPhysics(),
        controller: _scrollController,
        itemCount: hasReachedMax || notifications.isEmpty
            ? notifications.length
            : notifications.length + 1,
        itemBuilder: (ctx, index) {
          if (!hasReachedMax && index == notifications.length) {
            return const LoadMoreIndicator();
          }
          return NotificationItem(
            index: index,
            notification: notifications[index],
            onPressed: _onNotificationPressed,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          height: AppConstants.defaultPadding / 2,
        ),
      ),
    );
  }

  Widget _buildReadAllButton() {
    return IconButton(
      icon: const Icon(Icons.done_all),
      onPressed: _readAllPressed,
    );
  }

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (currentScroll == maxScroll && !_notificationCubit.hasReachedMax) {
      _notificationCubit.loadNotifications(
        isLoadMore: true,
      );
    }
  }

  void _hideRefreshIndicator() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  Future _onRefresh() async {
    _notificationCubit.loadNotifications(
      isRefresh: true,
    );
    return _refreshCompleter?.future;
  }

  _onNotificationPressed(index) {
    _notificationCubit.readNotification(index);
  }

  void _readAllPressed() {
    _notificationCubit.readAllNotifications();
  }
}
