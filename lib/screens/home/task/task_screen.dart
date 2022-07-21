import 'dart:io';

import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/resources/app_theme.dart';
import 'package:field_services/screens/home/task/task_cubit.dart';
import 'package:field_services/widgets/app_bar/app_bar_middle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TaskCubit _taskCubit;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _taskCubit = BlocProvider.of<TaskCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
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
      listener: (ctx, state) {},
      builder: (ctx, state) {
        return _buildBody();
      },
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildTabBar(),
      ],
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
}
