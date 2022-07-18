import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/screens/home/home_cubit.dart';
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
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (ctx, state) {
        return Center(
          child: Text('hello home screen \n current index $_currentIndex'),
        );
      },
    );
  }

  _buildBottomNavBar() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (ctx, state) {
        return BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          currentIndex: _currentIndex,
          onTap: _onBottomNavChange,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Task',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      },
    );
  }

  void _onBottomNavChange(int index) {
    if (_currentIndex == index) {
      return;
    }

    _currentIndex = index;
    _homeCubit.onRefreshUI();
  }
}
