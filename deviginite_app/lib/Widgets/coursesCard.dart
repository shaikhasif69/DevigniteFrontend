import 'package:flutter/material.dart';

class CoursesCard extends StatelessWidget {
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 100,
      width: 300,
      child: Stack(
        children: [
          Card(
            elevation: 3,
            child: Positioned(
                child: Material(
              child: Container(
                height: 100,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: new Offset(-10, 10.0),
                          blurRadius: 20.0,
                          spreadRadius: 4.0)
                    ]),
              ),
            )),
          ),
          Positioned(
              top: 0,
              left: 2,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  height: 90,
                  width: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/science.png"))),
                ),
              )),
          Positioned(
            top: 25,
            left: 95,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "Title",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                  ),
                  Text("Discription")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
