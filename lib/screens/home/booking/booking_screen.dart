import 'dart:async';
import 'dart:io';

import 'package:field_services/bases/base_state.dart';
import 'package:field_services/constants/app_constants.dart';
import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/screens/home/booking/booking_cubit.dart';
import 'package:field_services/widgets/di_refresh_indicator.dart';
import 'package:field_services/widgets/items/task_item.dart';
import 'package:field_services/widgets/load_more_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends BaseState<BookingScreen> {
  late BookingCubit _bookingCubit;
  PageController? _pageController;
  var _focusDay = DateTime.now();
  var _selectedDay = DateTime.now();
  var _currentCalendarFormat = CalendarFormat.week;
  final _scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    _bookingCubit = BlocProvider.of<BookingCubit>(context);
    _scrollController.addListener(_onScroll);
    _bookingCubit.loadBookings(selectedDate: _selectedDay);
    super.initState();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (ctx, state) {
        if (state is! BookingLoading) {
          _hideRefreshIndicator();
        }
        if (state is BookingLoaded) {
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

  Widget _buildBody(BookingState state) {
    final tasks = _bookingCubit.tasks;
    final hasReachedMax = _bookingCubit.hasReachedMax;
    return Column(
      children: [
        _buildHeader(),
        _buildCalendar(),
        const SizedBox(
          height: AppConstants.defaultPadding,
        ),
        if (state is BookingFailed) ...[
          Expanded(
            child: getErrorWidget(
              state.ex,
              onPressed: () => _bookingCubit.loadBookings(
                selectedDate: _selectedDay,
                isShowLoading: true,
              ),
            ),
          ),
        ] else if (state is BookingLoading || state is BookingInitial) ...[
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

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now().subtract(const Duration(days: 90)),
      lastDay: DateTime.now().add(const Duration(days: 90)),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      // eventLoader: _salesCalendarBloc.events,
      onCalendarCreated: (controller) => _pageController = controller,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: _currentCalendarFormat,
      // availableCalendarFormats: {
      //   CalendarFormat.month: LocalizationKey.commonMonthTitle.trans,
      //   CalendarFormat.week: LocalizationKey.commonWeek.trans,
      // },
      // locale: appLocalization.locale.toString(),
      availableGestures: AvailableGestures.none,
      calendarStyle: CalendarStyle(
        markersMaxCount: 1,
        canMarkersOverflow: false,
        markerDecoration: const BoxDecoration(
          color: AppColors.accentColor,
          shape: BoxShape.circle,
        ),
        selectedDecoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        leftChevronVisible: false,
        rightChevronVisible: false,
        formatButtonShowsNext: false,
        titleTextFormatter: (_, __) => '',
        formatButtonVisible: false,
        headerPadding: EdgeInsets.zero,
        headerMargin: EdgeInsets.zero,
      ),
      onDaySelected: _onDaySelected,
      onPageChanged: (focusDay) {
        _focusDay = focusDay;
        _bookingCubit.refreshUI();
      },
    );
  }

  Widget _buildHeader() {
    final currentDate = DateFormat.yMMMM(Platform.localeName).format(_focusDay);
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildHeaderButton(
            Icons.chevron_left,
            () => _onPreviousNextBtnPressed(false),
          ),
          Expanded(
            child: Center(
              child: Text(
                currentDate,
                style: AppTheme.titleTextStyle,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: _onCalendarFormatTogglePressed,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.mineShaft),
                ),
                padding: const EdgeInsets.symmetric(vertical: 6),
                alignment: Alignment.center,
                child: Text(
                  _currentCalendarFormat.name,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: AppConstants.defaultPadding,
          ),
          _buildHeaderButton(
            Icons.chevron_right,
            () => _onPreviousNextBtnPressed(true),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, Function() onPress) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.silver,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 26,
            color: AppColors.doveGrey,
          ),
        ),
      ),
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

  void _onScroll() {
    final currentScroll = _scrollController.position.pixels;
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (currentScroll == maxScroll && !_bookingCubit.hasReachedMax) {
      _bookingCubit.loadBookings(
        selectedDate: _selectedDay,
        isLoadMore: true,
      );
    }
  }

  void _hideRefreshIndicator() {
    _refreshCompleter?.complete();
    _refreshCompleter = Completer();
  }

  Future _onRefresh() async {
    _bookingCubit.loadBookings(
      selectedDate: _selectedDay,
      isRefresh: true,
    );
    return _refreshCompleter?.future;
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      },
    );
  }

  _onTaskPressed() {}

  void _onPreviousNextBtnPressed(bool isNext) {
    if (isNext) {
      _pageController?.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
      return;
    }

    _pageController?.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  void _onCalendarFormatTogglePressed() {
    if (_currentCalendarFormat == CalendarFormat.week) {
      _currentCalendarFormat = CalendarFormat.month;
      _bookingCubit.refreshUI();
      return;
    }
    _currentCalendarFormat = CalendarFormat.week;
    _bookingCubit.refreshUI();
  }

  void _onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    _selectedDay = selectedDay;
    _focusDay = focusedDay;
    _bookingCubit.loadBookings(
      selectedDate: _selectedDay,
      isRefresh: true,
    );
  }
}
