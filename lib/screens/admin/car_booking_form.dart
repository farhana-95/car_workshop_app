import 'package:car_workshop_app/screens/admin/tabs/booking_details_tab.dart';
import 'package:car_workshop_app/screens/admin/tabs/car_info_tab.dart';
import 'package:car_workshop_app/screens/admin/tabs/customer_info_tab.dart';
import 'package:flutter/material.dart';

import 'package:car_workshop_app/const/color.dart';

class CarBookingForm extends StatefulWidget {
  const CarBookingForm({super.key});

  @override
  State<CarBookingForm> createState() => _CarBookingFormState();
}

class _CarBookingFormState extends State<CarBookingForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Booking Service',
          style: TextStyle(color: ColorList.blue),
        ),
        centerTitle: true,
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: ColorList.blue,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Car'),
            Tab(text: 'Customer'),
            Tab(text: 'Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarInfoTab(tabController: _tabController),
          CustomerInfoTab(tabController: _tabController),
          BookingDetailsTab(
            tabController: _tabController,
          ),
        ],
      ),
    );
  }
}
