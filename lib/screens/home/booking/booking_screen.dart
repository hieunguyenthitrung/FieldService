import 'dart:io';

import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/screens/home/booking/booking_cubit.dart';
import 'package:field_services/widgets/app_bar/app_bar_middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late BookingCubit _taskCubit;
  PageController? _pageController;
  var _focusDay = DateTime.now();
  var _selectedDay = DateTime.now();
  var _currentCalendarFormat = CalendarFormat.week;

  @override
  void initState() {
    _taskCubit = BlocProvider.of<BookingCubit>(context);
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
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildHeader(),
        _buildCalendar(),
        Expanded(
          child: _buildContent(),
        ),
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
        _taskCubit.refreshUI();
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
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      currentDate,
                      style: AppTheme.titleTextStyle,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 70,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: _onCalendarFormatTogglePressed,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: AppColors.mineShaft),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          _currentCalendarFormat.name,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

  Widget _buildContent() {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (ctx, index) {
        return Container();
      },
    );
  }

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
      _taskCubit.refreshUI();
      return;
    }
    _currentCalendarFormat = CalendarFormat.week;
    _taskCubit.refreshUI();
  }

  void _onDaySelected(
    DateTime selectedDay,
    DateTime focusedDay,
  ) {
    _selectedDay = selectedDay;
    _focusDay = focusedDay;
    _taskCubit.refreshUI();
  }
}
