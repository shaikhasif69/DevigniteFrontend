import 'package:deviginite_app/model/subject.dart';
import 'package:deviginite_app/provider/Student/learningPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SubjectCards extends ConsumerStatefulWidget {
  @override
  ConsumerState<SubjectCards> createState() {
    return _SubjectCards();
    throw UnimplementedError();
  }
}

class _SubjectCards extends ConsumerState<SubjectCards> {
  _SubjectCards();
  int selectedSub = -1;

  Widget build(context) {
    ref.watch(LearningPageProvider);
    int data = ref.read(LearningPageProvider.notifier).selectedSubIs();
    // print("data is : " + data.toString());

    int i = -1;
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 200) / 2;
    final double itemWidth = size.width / 1.6;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Column(
          children: [
            Card(
                child: SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Subjects!",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ],
        ),
        toolbarHeight: 100,
        centerTitle: true,
      ),
      body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 3,
            mainAxisExtent: 290,
            crossAxisSpacing: 0,
          ),
          children: [
            ...subjectList.map((
              e,
            ) {
              i++;
              return RollCard(
                  selectedIndex: data == i ? true : false,
                  image: e['assets'],
                  title: e['name'],
                  subTitle: e['description'],
                  navigate: () {});
            })
          ]),
    );
  }
}

class RollCard extends ConsumerStatefulWidget {
  RollCard(
      {super.key,
      required this.selectedIndex,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.navigate});
  final void Function() navigate;

  final String image;
  final bool selectedIndex;
  final String title;
  final String subTitle;

  @override
  ConsumerState<RollCard> createState() {
    return _RollCard();
  }
}

class _RollCard extends ConsumerState<RollCard> {
  Widget build(context) {
    return InkWell(
      onTap: widget.navigate,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Card(
          color: widget.selectedIndex == true
              ? Theme.of(context).colorScheme.primaryContainer
              : null,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: CircleAvatar(
                  // backgroundColor: ,
                  radius: 60,
                  backgroundImage: AssetImage(widget.image),
                ),
              ),
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20),
              ),
              Text(
                widget.subTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Center(
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.info,
                        size: 20,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
