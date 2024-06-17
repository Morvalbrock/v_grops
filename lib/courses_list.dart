import 'package:Sivayogi_The_Guru/courses.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CourcesList extends StatelessWidget {
  CourcesList({super.key, required this.alldata, required this.index});
  final List<CourcesModel> alldata;
  int index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xfffeeeee),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 63, 62, 62).withOpacity(0.50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                alldata[index].sub_title_1.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xfffeeeee),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 63, 62, 62).withOpacity(0.50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                alldata[index].sub_title_2.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xfffeeeee),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 63, 62, 62).withOpacity(0.50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                alldata[index].sub_title_3.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xfffeeeee),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 63, 62, 62).withOpacity(0.50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                alldata[index].sub_title_4.toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 80,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xfffeeeee),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 63, 62, 62).withOpacity(0.50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Text(
                alldata[index].sub_title_5.toString(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
