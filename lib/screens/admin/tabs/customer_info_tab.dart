import 'package:car_workshop_app/components/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_app/components/text_form_field.dart';
import 'package:car_workshop_app/components/error_dialog.dart';
import 'package:car_workshop_app/controllers/booking_form_controller.dart';

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
  void initState(){
    super.initState();
  }

  @override
  void dispose() {
    customerNameController.dispose();
    customerPhoneController.dispose();
    customerEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: screenHeight*0.010),
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
                SizedBox(height: screenHeight * 0.018),
                CustomTextFormField(
                  controller: customerNameController,
                  label: 'Name',
                ),
                SizedBox(height: screenHeight * 0.018),
                CustomTextFormField(
                  controller: customerPhoneController,
                  label: 'Phone Number',
                ),
                SizedBox(height: screenHeight * 0.018),
                CustomTextFormField(
                  controller: customerEmailController,
                  label: 'Email',
                ),
                SizedBox(height: screenHeight * 0.035),
                Center(
                  child: CommonButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        try{
                          ref
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
