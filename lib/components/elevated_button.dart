import 'package:flutter/material.dart';

import 'package:car_workshop_app/const/color.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const CommonButton({
    super.key,
    required this.onPressed,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorList.blue,
        foregroundColor: ColorList.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(title),
    );
  }
}
