import 'package:car_workshop_app/components/elevated_button.dart';
import 'package:car_workshop_app/controllers/auth_controller.dart';
import 'package:car_workshop_app/models/users.dart';
import 'package:car_workshop_app/screens/admin/admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_workshop_app/components/text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:car_workshop_app/components/error_dialog.dart';
import 'package:car_workshop_app/controllers/booking_form_controller.dart';

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
  String? selectedMechanicId;
  late List<UserModel> _mechanics = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchMechanics();
  }

  @override
  void dispose() {
    bookingTitleController.dispose();
    startDateTimeController.dispose();
    endDateTimeController.dispose();
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
                SizedBox(height: screenHeight * 0.01),
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
                SizedBox(height: screenHeight* 0.018),
                CustomTextFormField(
                  controller: bookingTitleController,
                  label: 'Booking Title',
                ),
                SizedBox(height: screenHeight* 0.018),
                CustomTextFormField(
                  controller: startDateTimeController,
                  label: 'Start DateTime',
                  isDateTimePicker: true,
                  onTap: () => _selectDateTime(startDateTimeController),
                ),
                SizedBox(height: screenHeight* 0.018),
                CustomTextFormField(
                  controller: endDateTimeController,
                  label: 'End DateTime',
                  isDateTimePicker: true,
                  onTap: () => _selectDateTime(endDateTimeController),
                ),
                SizedBox(height: screenHeight* 0.028),
                const Text(
                  'Assign Mechanic',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: screenHeight* 0.014),
                DropdownButtonFormField<String>(
                  value: selectedMechanicId,
                  hint: const Text('Assign Mechanic'),
                  onChanged: (newValue) {
                    final selectedMechanicModel = _mechanics
                        .firstWhere((mechanic) => mechanic.uid == newValue);
                    setState(() {
                      selectedMechanicId = newValue;
                      selectedMechanic = selectedMechanicModel.name;
                    });
                  },
                  items: _mechanics.map((UserModel mechanic) {
                    return DropdownMenuItem<String>(
                      value: mechanic.uid,
                      child: Text(
                        mechanic.name!,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: screenHeight*0.02,horizontal: screenWidth * 0.08),
                    filled: true,
                    fillColor: Colors.grey[200],
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight* 0.035),
                Center(
                  child: CommonButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          DateTime startDateTime =
                              DateFormat('dd/MM/yyyy HH:mm')
                                  .parse(startDateTimeController.text);
                          DateTime endDateTime = DateFormat('dd/MM/yyyy HH:mm')
                              .parse(endDateTimeController.text);

                          ref.read(carInfoStateProvider.notifier).update(
                              (state) => state.copyWith(
                                  bookingTitle: bookingTitleController.text,
                                  startDateTime: startDateTime,
                                  endDateTime: endDateTime,
                                  assignedMechanic: selectedMechanic,
                                  mechanicId: selectedMechanicId));
                          final updatedBooking = ref.read(carInfoStateProvider);
                          await ref
                              .read(bookingControllerProvider.notifier)
                              .addBooking(updatedBooking);
                          if (context.mounted) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const AdminScreen()),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showErrorDialog(context, e.toString());
                          }
                        }
                      }
                    },
                    title: 'Submit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchMechanics() async {
    final mechanics =
        await ref.read(authControllerProvider.notifier).fetchMechanics();
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
            DateFormat('dd/MM/yyyy HH:mm').format(combinedDateTime);

        controller.text = formattedDateTime;
      }
    }
  }
}
