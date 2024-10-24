import 'package:car_workshop_app/components/elevated_button.dart';
import 'package:car_workshop_app/components/text_form_field.dart';
import 'package:car_workshop_app/controllers/booking_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/booking_model.dart';

class CarInfoTab extends ConsumerStatefulWidget {
  final TabController tabController;

  const CarInfoTab({super.key, required this.tabController});

  @override
  ConsumerState<CarInfoTab> createState() => _CarInfoTabState();
}

class _CarInfoTabState extends ConsumerState<CarInfoTab> {
  @override
  Widget build(BuildContext context) {
    final carMakeController = TextEditingController();
    final carModelController = TextEditingController();
    final carYearController = TextEditingController();
    final registrationPlateController = TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    'Enter Car Information',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  controller: carMakeController,
                  label: 'Make',
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  controller: carModelController,
                  label: 'Model',
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  controller: carYearController,
                  label: 'Year',
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  controller: registrationPlateController,
                  label: 'Registration Plate',
                ),
                const SizedBox(height: 35),
                Center(
                  child: CommonButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final currentState = ref.read(carInfoStateProvider.notifier).state;

                        final carInfo = ref
                            .read(carInfoStateProvider.notifier)
                            .update((state) => BookingModel(
                                carMake: carMakeController.text,
                                carModel: carModelController.text,
                                carYear: carYearController.text,
                                registrationPlate:
                                    registrationPlateController.text,
                                customerEmail: currentState.customerEmail,
                                customerName: currentState.customerName,
                                customerPhone: currentState.customerPhone,
                                bookingTitle: currentState.bookingTitle,
                                startDateTime: currentState.startDateTime,
                                endDateTime: currentState.endDateTime));
                        print(
                            'CarInfo ${carInfo.carMake} ${carInfo.carModel} ${carInfo.carYear}');
                        widget.tabController.animateTo(1);
                      }
                    },
                    title: 'Next',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
