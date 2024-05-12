import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v_group/profilepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              icon: Image.asset(
                'assets/icons/home.png',
                color: Colors.white,
              ),
            ),
            label: AppLocalizations.of(context)!.home),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'books');
              },
              icon: Image.asset(
                'assets/icons/book.png',
                color: Colors.white,
                width: 13,
                height: 13,
              ),
            ),
            label: AppLocalizations.of(context)!.books),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'about');
              },
              icon: Image.asset(
                'assets/icons/about.png',
                color: Colors.white,
              ),
            ),
            label: AppLocalizations.of(context)!.about),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: Image.asset(
              'assets/icons/user.png',
              color: Colors.white,
            ),
          ),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
    ),
  );
}

// Drawer

Widget CustomDrawer(context, String userName, String image_url) {
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
                backgroundColor: Colors.white,
                radius: 60,
                child: CircleAvatar(
                  radius: 58,
                  backgroundImage: image_url.isNotEmpty
                      ? NetworkImage(image_url)
                      : AssetImage('assets/images/placeholder.jpg')
                          as ImageProvider,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                userName,
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
            leading: Image.asset(
              'assets/icons/home.png',
              width: 18,
              height: 18,
            ),
            title: Text(
              AppLocalizations.of(context)!.home,
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
            leading: Image.asset(
              'assets/icons/book.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.books,
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
                'Books',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/branch.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.branches,
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
            leading: Image.asset(
              'assets/icons/online-learning.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.courses,
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
            leading: Image.asset(
              'assets/icons/helicopter.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.donations,
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
                'donation',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/about.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.about,
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
                'about',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/user.png',
              width: 20,
              height: 20,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.profile,
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
                'profile',
              );
            },
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
            leading: Image.asset(
              'assets/icons/exit.png',
              width: 18,
              height: 18,
              color: const Color.fromARGB(136, 0, 0, 0),
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.log_out,
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
