import 'package:deviginite_app/provider/Student/HomePageProvider.dart';
import 'package:deviginite_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PremiumCourseCard extends ConsumerStatefulWidget {
  PremiumCourseCard(
      {super.key,
      required this.selected,
      required this.title,
      required this.Subtitle,
      required this.image});
  bool selected;
  String title;
  String Subtitle;
  String image;

  @override
  ConsumerState<PremiumCourseCard> createState() => _PremiumCourseCardState();
}

class _PremiumCourseCardState extends ConsumerState<PremiumCourseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: widget.selected
                ? BorderSide(color: Colors.amber, width: 4)
                : BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(18)),
        elevation: 10,
        child: Container(
          width: widget.selected
              ? MediaQuery.of(context).size.width * 0.60
              : MediaQuery.of(context).size.width * 0.47,
          decoration: BoxDecoration(
            border: widget.selected
                ? Border.all(
                    width: 4,
                    color: Theme.of(context).colorScheme.primaryContainer)
                : null,
            color: AppConstants.myColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x3600000F),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.asset(
                          widget.image,
                          width: 110,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                        child: Text(
                          widget.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 4, 0, 0),
                        child: SizedBox(
                          width: 170,
                          child: Text(
                            widget.Subtitle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
