import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/screens/home/booking/booking_screen.dart';
import 'package:field_services/screens/home/home_cubit.dart';
import 'package:field_services/screens/home/notification/notification_screen.dart';
import 'package:field_services/screens/home/profile/profile_screen.dart';
import 'package:field_services/screens/home/task/task_screen.dart';
import 'package:field_services/utils/triple.dart';
import 'package:field_services/widgets/app_bar/app_bar_middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (ctx, state) {
        final items = _screens.map((e) => e.third).toList();
        return IndexedStack(
          key: const PageStorageKey('home_storage_key'),
          index: _currentIndex,
          children: items,
        );
      },
    );
  }

  _buildBottomNavBar() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (ctx, state) {
        final items = _screens
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.second),
                label: e.first,
              ),
            )
            .toList();
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          currentIndex: _currentIndex,
          onTap: _onBottomNavChange,
          items: items,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final titles = _screens.map((e) => e.first).toList();
          return AppBarMiddleText(
            isBackNavigation: false,
            isShowShadow: true,
            leadWidget: _buildLeadingButton(),
            actionWidgets: [
              _buildNotificationButton(),
            ],
            title: titles[_currentIndex],
          );
        },
      ),
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
      onPressed: _onNotificationPressed,
      icon: const Icon(Icons.notifications),
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      iconSize: 24,
      onPressed: _onLogoutPressed,
      icon: const Icon(Icons.logout),
    );
  }

  List<Triple<String, IconData, Widget>> get _screens => [
        Triple(
          'Task',
          Icons.task,
          const TaskScreen(),
        ),
        Triple(
          'Booking',
          Icons.calendar_month,
          const BookingScreen(),
        ),
        Triple(
          'Profile',
          Icons.person,
          const ProfileScreen(),
        ),
      ];

  void _onBottomNavChange(int index) {
    if (_currentIndex == index) {
      return;
    }

    _currentIndex = index;
    _homeCubit.onRefreshUI();
  }

  void _onLogoutPressed() {}

  void _onNotificationPressed() {}
}
