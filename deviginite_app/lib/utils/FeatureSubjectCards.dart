import 'package:deviginite_app/provider/Student/HomePageProvider.dart';
import 'package:deviginite_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeaturedSubjectCards extends ConsumerStatefulWidget {
  @override
  ConsumerState<FeaturedSubjectCards> createState() {
    return _FeaturedSubjectCards();
    throw UnimplementedError();
  }
}

class _FeaturedSubjectCards extends ConsumerState<FeaturedSubjectCards> {
  // final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    ref.watch(HomePagesegmentProvider);
    int data = ref.read(HomePagesegmentProvider.notifier).selectedSegment();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Container(
        // width: 300,
        height: 105,
        // padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          border: data == 1
              ? Border.all(
                  width: 4, color: Theme.of(context).colorScheme.inversePrimary)
              : null,
          borderRadius: BorderRadius.circular(18),
          // gradient: LinearGradient(
          //   // colors: gradientColors,
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight,
          // ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                child: Image(
                  image: AssetImage("assets/quiz.png"),
                ),
              ),
            ),
            SizedBox(width: 15),
            Text(
              "Quiz",
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
      ),
    );
  }
}
