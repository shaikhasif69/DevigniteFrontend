import 'package:flutter/material.dart';
import 'package:deviginite_app/utils/app_constants.dart';

class MyButton extends StatelessWidget {
  String text;
  Function()? onTap;
  MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppConstants.appPrimary,
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
        )),
      ),
    );
  }
}
