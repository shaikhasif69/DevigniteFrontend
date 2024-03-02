import 'package:deviginite_app/utils/app_constants.dart';
import 'package:flutter/material.dart';

class EventFeatureItem {
  final String name;
  final String imagePath;

  EventFeatureItem(this.name, this.imagePath);
}

var eventFeatureItems = [
  EventFeatureItem(
      'Basic English!', 'assets/images/rock&concert.jpg'),
  EventFeatureItem('Code with ASIF', 'assets/images/hackathon1.jpg')
];

class FeaturedSubjectCards extends StatelessWidget {
  const FeaturedSubjectCards(
    this.eventFeatureItem, {
    this.gradientColors = const [
      Color(0xFFDCBFFF), // Light blue0xFFDCBFFF
      Color(0xFFE5D4FF), // Dark blue
    ],
  });

  final EventFeatureItem eventFeatureItem;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 105,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              child: Image(
                image: AssetImage(eventFeatureItem.imagePath),
              ),
            ),
          ),
          SizedBox(width: 15),
          Text(
            eventFeatureItem.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white, // Text color
            ),
              maxLines: 2, // Allow up to 2 lines
              overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
