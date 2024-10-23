import 'package:car_workshop_app/screens/admin/tabs/booking_details_tab.dart';
import 'package:car_workshop_app/screens/admin/tabs/car_info_tab.dart';
import 'package:car_workshop_app/screens/admin/tabs/customer_info_tab.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Booking Cars'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Car Info'),
            Tab(text: 'Customer Info'),
            Tab(text: 'Booking Details'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarInfoTab(tabController: _tabController),
          CustomerInfoTab(tabController: _tabController),
          const BookingDetailsTab(),
        ],
      ),
    );
  }
}
