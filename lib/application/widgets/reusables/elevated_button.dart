import 'package:flutter/material.dart';
import 'package:sss/utils/app_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {required this.buttonText, required this.onClicked, super.key});

  final void Function() onClicked;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onClicked,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primaryColor,
            padding: const EdgeInsets.all(8)),
        child: Text(
          buttonText,
        ));
  }
}
