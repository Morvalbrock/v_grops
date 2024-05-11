import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor('368FF8'),
                HexColor('025CAF'),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        title: Text(
          "Donation Page",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                child: Lottie.asset(
                  'assets/animation/donation.json',
                  fit: BoxFit.contain,
                  width: 300,
                  height: 250,
                  repeat: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Display video thumbnail (consider caching with cached_network_image)
                          Lottie.asset(
                            'assets/animation/location.json',
                            fit: BoxFit.contain,
                            width: 80,
                            height: 80,
                            repeat: true,
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Overseas donation',
                                    style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'A. Sivakumar\n',
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 2,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                      ),
                                      TextSpan(
                                        text:
                                            'A/C  - 054601000028843\nIFSC - IOB0000546\n',
                                        style: TextStyle(
                                            color: Color.fromARGB(155, 0, 0, 0),
                                            letterSpacing: 2,
                                            height: 1.5),
                                      ),
                                      TextSpan(
                                        text:
                                            'MICR - 600020050 \nSW Code - IOBAINBB001\n',
                                        style: TextStyle(
                                            color: Color.fromARGB(155, 0, 0, 0),
                                            letterSpacing: 2,
                                            height: 1.5),
                                      ),
                                      TextSpan(
                                        text:
                                            'Indian Overseas Bank, Villivakkam Branch,\n18, Perumal Koil North, \nVillivakkam,Chennai - 600049. ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            height: 1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Display video thumbnail (consider caching with cached_network_image)
                          Lottie.asset(
                            'assets/animation/location.json',
                            fit: BoxFit.contain,
                            width: 80,
                            height: 80,
                            repeat: true,
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'India donation',
                                    style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Yogakudil Trust\n',
                                          style: TextStyle(
                                              color: Colors.black,
                                              letterSpacing: 2,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              height: 1.5),
                                        ),
                                        TextSpan(
                                          text:
                                              'A/C  - 920010038927038\nIFSC - UTIB0001565\nA\C Type : Savings\n',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(155, 0, 0, 0),
                                              letterSpacing: 2,
                                              height: 1.5),
                                        ),
                                        TextSpan(
                                          text: 'Villivakkam Branch,\n',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(155, 0, 0, 0),
                                              letterSpacing: 2,
                                              height: 1.5),
                                        ),
                                        TextSpan(
                                          text: 'Chennai - 600049',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              height: 1.5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
