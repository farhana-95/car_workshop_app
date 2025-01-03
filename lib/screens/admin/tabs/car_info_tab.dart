import 'package:car_workshop_app/components/elevated_button.dart';
import 'package:car_workshop_app/components/text_form_field.dart';
import 'package:car_workshop_app/controllers/booking_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:car_workshop_app/components/error_dialog.dart';

class CarInfoTab extends ConsumerStatefulWidget {
  final TabController tabController;

  const CarInfoTab({super.key, required this.tabController});

  @override
  ConsumerState<CarInfoTab> createState() => _CarInfoTabState();
}

class _CarInfoTabState extends ConsumerState<CarInfoTab> {
  final carMakeController = TextEditingController();
  final carModelController = TextEditingController();
  final carYearController = TextEditingController();
  final registrationPlateController = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    carMakeController.dispose();
    carModelController.dispose();
    carYearController.dispose();
    registrationPlateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    ref.watch(carInfoStateProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: screenHeight * 0.010),
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
                SizedBox(height: screenHeight* 0.018),
                CustomTextFormField(
                  controller: carMakeController,
                  label: 'Make',
                ),
                SizedBox(height: screenHeight * 0.018),
                CustomTextFormField(
                  controller: carModelController,
                  label: 'Model',
                ),
                SizedBox(height: screenHeight* 0.018),
                CustomTextFormField(
                  controller: carYearController,
                  label: 'Year',
                ),
                SizedBox(height: screenHeight * 0.018),
                CustomTextFormField(
                  controller: registrationPlateController,
                  label: 'Registration Plate',
                ),
                SizedBox(height:screenHeight* 0.035),
                Center(
                  child: CommonButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try {
                          ref
                              .read(carInfoStateProvider.notifier)
                              .update((state) => state.copyWith(
                                    carMake: carMakeController.text,
                                    carModel: carModelController.text,
                                    carYear: carYearController.text,
                                    registrationPlate:
                                        registrationPlateController.text,
                                  ));
                          widget.tabController.animateTo(1);
                        } catch (e) {
                          if (context.mounted) {
                            showErrorDialog(context, e.toString());
                          }
                        }
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
