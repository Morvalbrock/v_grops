import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_group/profilepage.dart';

Widget BottomNavBar(context, index) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        tileMode: TileMode.repeated,
        colors: [
          HexColor('368FF8'),
          HexColor('025CAF'),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
    height: MediaQuery.of(context).size.height * 0.10,
    child: BottomNavigationBar(
      iconSize: 20,
      currentIndex: index,
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: HexColor('5CC1EC'),
      unselectedItemColor: Colors.white,
      selectedFontSize: 10,
      unselectedFontSize: 12,
      onTap: (value) {},
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'home',
                );
              },
              icon: const Icon(
                Icons.home,
              ),
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'search');
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            label: "Search"),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'about');
              },
              icon: const Icon(
                Icons.group,
              ),
            ),
            label: "Abouts"),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.person,
            ),
          ),
          label: "Profile",
        ),
      ],
    ),
  );
}

// Drawer

Widget CustomDrawer(context) {
  return Drawer(
    elevation: 12.0,
    width: 280.0,
    child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: HexColor('025CAF'),
                child: const Text(
                  'PK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.03,
                  ),
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              const Text(
                'Praveen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.01,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.home,
              size: 21.0,
            ),
            title: const Text(
              'Home',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'home',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.search,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Seach',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'search',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.museum_outlined,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Branches',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.class_outlined,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Courses',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'cources');
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.attach_money_rounded,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Donations',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.people,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Abouts',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.person,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.edit,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Edit Content',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'editing',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              size: 21.0,
            ),
            title: const Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
      ],
    ),
  );
}

Widget TabButton(context, gobalkey) {
  return Builder(
    builder: (context) => FabCircularMenuPlus(
      key: gobalkey,
      alignment: Alignment.bottomRight,
      ringColor: Colors.blue.withAlpha(80),
      ringDiameter: 280.0,
      ringWidth: 50.0,
      fabSize: 40.0,
      fabElevation: 8.0,
      fabIconBorder: CircleBorder(),
      fabColor: Colors.white,
      fabOpenIcon: Icon(Icons.menu, color: Colors.black),
      fabCloseIcon: Icon(Icons.close, color: Colors.black),
      // fabMargin: const EdgeInsets.all(16.0),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,

      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            final Uri _urlyoutube =
                Uri.parse('https://www.youtube.com/@vallarasutv/videos');

            _launchUrl(_urlyoutube);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(
            Icons.video_camera_front_rounded,
            color: Colors.black,
            size: 25,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            final Uri _urlfacbook = Uri.parse('https://www.facebook.com/');
            _launchUrl(_urlfacbook);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(
            Icons.facebook,
            color: Colors.black,
            size: 25,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            final Uri _url = Uri.parse('https://vallarasuparty.com/');

            _launchUrl(_url);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(
            Icons.wechat_outlined,
            color: Colors.black,
            size: 25.0,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            final Uri _urlinstagram =
                Uri.parse('https://www.instagram.com/accounts/login/?hl=en');
            _launchUrl(_urlinstagram);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Icon(
            Icons.web,
            color: Colors.black,
            size: 25,
          ),
        )
      ],
    ),
  );
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
