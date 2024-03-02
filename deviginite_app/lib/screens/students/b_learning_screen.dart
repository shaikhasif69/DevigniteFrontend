import 'package:deviginite_app/utils/app_constants.dart';
import 'package:flutter/material.dart';

class BLearningScreen extends StatefulWidget {
  const BLearningScreen({super.key});

  @override
  State<BLearningScreen> createState() => _BLearningScreenState();
}

class _BLearningScreenState extends State<BLearningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppConstants.appSecondaryBack,
    );
  }
}