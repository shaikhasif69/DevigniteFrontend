import 'package:deviginite_app/provider/Student/HomePageProvider.dart';
import 'package:deviginite_app/provider/flutterTTSProvider.dart';
import 'package:deviginite_app/tabs/premium_course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AllAssignmentList extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AllAssignment();
    throw UnimplementedError();
  }
}

class _AllAssignment extends ConsumerState<AllAssignmentList> {
  ItemScrollController _scrollController = ItemScrollController();

  void initState() {
    super.initState();
    ref.read(HomePagesegmentProvider.notifier).scrollController =
        _scrollController;
  }

  Widget build(context) {
    ref.watch(HomePagesegmentProvider);

    Map<String, List> data = ref.watch(HomePagesegmentProvider);
    String seletedSeg = ref.read(HomePagesegmentProvider.notifier).selectedSeg;
    int seletedIndex = ref.read(HomePagesegmentProvider.notifier).SelectedInt;
    if (seletedSeg == "assignment" && seletedIndex != -1) {
      ref.read(FLutterTTSProvider.notifier).ftts.speak(ref
          .read(HomePagesegmentProvider.notifier)
          .state[seletedSeg]![seletedIndex]['title']);
    }
    return Card(
      elevation: seletedSeg == "assignment" ? 15 : 10,
      color: ref.read(HomePagesegmentProvider.notifier).bg,
      shape: RoundedRectangleBorder(
          side: seletedSeg == "assignment"
              ? BorderSide(color: Colors.amber, width: 4)
              : BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "New Assignment",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            child: ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: data['assignment']!
                  .length, // Change this to the number of items you want to display
              itemBuilder: (context, index) {
                return PremiumCourseCard(
                  title: data['assignment']![index]['title'],
                  Subtitle: data['assignment']![index]['subTitle'],
                  image: data['assignment']![index]['image'],
                  selected: seletedIndex == index ? true : false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
