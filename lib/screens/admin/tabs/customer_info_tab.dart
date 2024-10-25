import 'package:car_workshop_app/components/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_app/components/text_form_field.dart';

import '../../../components/error_dialog.dart';
import '../../../controllers/booking_form_controller.dart';
import '../../../models/booking_model.dart';

class CustomerInfoTab extends ConsumerStatefulWidget {
  final TabController tabController;

  const CustomerInfoTab({super.key, required this.tabController});

  @override
  ConsumerState<CustomerInfoTab> createState() => _CustomerInfoTabState();
}

class _CustomerInfoTabState extends ConsumerState<CustomerInfoTab> {
  final customerNameController = TextEditingController();
  final customerPhoneController = TextEditingController();
  final customerEmailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    customerNameController.dispose();
    customerPhoneController.dispose();
    customerEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentState = ref.watch(carInfoStateProvider);

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
                    'Customer Information',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  controller: customerNameController,
                  label: 'Name',
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  controller: customerPhoneController,
                  label: 'Phone Number',
                ),
                const SizedBox(height: 18),
                CustomTextFormField(
                  controller: customerEmailController,
                  label: 'Email',
                ),
                const SizedBox(height: 35),
                Center(
                  child: CommonButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try{
                          final customer = ref
                              .read(carInfoStateProvider.notifier)
                              .update((state) => state.copyWith(
                                    customerName: customerNameController.text,
                                    customerEmail: customerEmailController.text,
                                    customerPhone: customerPhoneController.text,
                                  ));
                          widget.tabController.animateTo(2);
                        }catch(e){
                          if(context.mounted){
                            showErrorDialog(context,e.toString());
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
