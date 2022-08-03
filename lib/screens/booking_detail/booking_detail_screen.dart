import 'package:field_services/resources/app_colors.dart';
import 'package:field_services/widgets/app_bar/app_bar_middle_text.dart';
import 'package:flutter/material.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({Key? key}) : super(key: key);

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMiddleText(title: 'as'),
      body: _buildBody(),
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
      isScrollable: true,
      tabs: const [
        Tab(
          text: 'aaaaaa',
        ),
        Tab(
          text: 'bbbbbbb',
        ),
        Tab(
          text: 'ccccccccc',
        ),
        Tab(
          text: 'ddddddd',
        ),
      ],
    );
  }
}
