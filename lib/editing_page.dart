import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EditingPage extends StatefulWidget {
  const EditingPage({super.key});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editing Page',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          InkWell(
            child: Card(
              elevation: 5,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: AssetImage('assets/images/editpage.png')),
                      SizedBox(
                        width: 8,
                      ),
                      Center(
                          child: Text(
                        "Welcome to editing \n your content",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 68, 68, 68)),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                        color: HexColor('025CAF'),
                        borderRadius: BorderRadius.circular(16)),
                    height: 280,
                    width: 150,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Edit profile page",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Image(
                              image:
                                  AssetImage('assets/images/profile_edit.png'),
                              height: 130),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Edit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 45,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 25,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              const SizedBox(
                height: 6,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    decoration: BoxDecoration(
                        color: HexColor('025CAF'),
                        borderRadius: BorderRadius.circular(16)),
                    height: 280,
                    width: 150,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Edit about page ",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Image(
                              image: AssetImage('assets/images/about_edit.png'),
                              height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Edit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 45,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 25,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
