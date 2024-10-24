import 'package:car_workshop_app/components/elevated_button.dart';
import 'package:car_workshop_app/controllers/auth_controller.dart';
import 'package:car_workshop_app/models/users.dart';
import 'package:car_workshop_app/screens/admin/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_app/components/text_form_field.dart';
import 'package:intl/intl.dart';

import '../../../controllers/booking_form_controller.dart';
import '../../../models/booking_model.dart';

class BookingDetailsTab extends ConsumerStatefulWidget {
  final TabController tabController;

  const BookingDetailsTab({super.key, required this.tabController});

  @override
  ConsumerState<BookingDetailsTab> createState() => _BookingDetailsTabState();
}

class _BookingDetailsTabState extends ConsumerState<BookingDetailsTab> {
  final bookingTitleController = TextEditingController();
  final startDateTimeController = TextEditingController();
  final endDateTimeController = TextEditingController();
  String? selectedMechanic;
  late List<UserModel> _mechanics = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchMechanics(); // Fetch mechanics on widget initialization
  }

  @override
  void dispose() {
    bookingTitleController.dispose();
    startDateTimeController.dispose();
    endDateTimeController.dispose();
    super.dispose();
  }

  Future<void> _fetchMechanics() async {
    final mechanics =
        await ref.read(authControllerProvider.notifier).fetchMechanics();
    print('MEchanics $_mechanics');
    setState(() {
      _mechanics = mechanics;
    });
  }

  Future<void> _selectDateTime(TextEditingController controller) async {
    DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDateTime != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        String formattedDateTime =
            DateFormat('dd-MM-yyyy HH:mm').format(combinedDateTime);

        controller.text = formattedDateTime;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Booking Details',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 18),
          CustomTextFormField(
            controller: bookingTitleController,
            label: 'Booking Title',
          ),
          const SizedBox(height: 18),
          CustomTextFormField(
            controller: startDateTimeController,
            label: 'Start DateTime',
            onTap: () => _selectDateTime(startDateTimeController),
          ),
          const SizedBox(height: 18),
          CustomTextFormField(
            controller: endDateTimeController,
            label: 'End DateTime',
            onTap: () => _selectDateTime(endDateTimeController),
          ),
          const SizedBox(height: 28),
          const Text(
            'Assign Mechanic',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            value: selectedMechanic,
            hint: const Text('Assign Mechanic'),
            onChanged: (newValue) {
              setState(() {
                selectedMechanic = newValue;
              });
            },
            items: _mechanics.map((UserModel mechanic) {
              return DropdownMenuItem<String>(
                value: mechanic.uid,
                child: Text(
                  mechanic.email!,
                  style: const TextStyle(color: Colors.black),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              filled: true,
              fillColor: Colors.grey[200],
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.black, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
          const SizedBox(height: 35),
          Center(
            child: CommonButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final details = ref
                      .watch(carInfoStateProvider.notifier)
                      .update((state) => BookingModel(
                            bookingTitle: bookingTitleController.text,
                            startDateTime:
                                DateTime.parse(startDateTimeController.text),
                            endDateTime:
                                DateTime.parse(endDateTimeController.text),
                          ));
                  print('DetailsInfo $details');
                  print('InfoProvider ${ref.watch(carInfoStateProvider)}');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const AdminScreen()),
                  );
                }
              },
              title: 'Submit',
            ),
          ),
        ],
      ),
    );
  }
}
