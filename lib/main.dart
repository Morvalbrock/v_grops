import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v_group/aboutspage.dart';
import 'package:v_group/courses.dart';
import 'package:v_group/courses_page.dart';
import 'package:v_group/editing_page.dart';
import 'package:v_group/home.dart';
import 'package:v_group/imagepage.dart';
import 'package:v_group/loginscreen.dart';
import 'package:v_group/profilepage.dart';
import 'package:v_group/registerpage.dart';
import 'package:v_group/searchpage.dart';

var KColorScheme = ColorScheme.fromSeed(
  seedColor: HexColor('025CAF'),
);
void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData().copyWith(
      //   useMaterial3: true,
      //   colorScheme: KColorScheme,
      //   primaryColor: HexColor('025CAF'),
      //   scaffoldBackgroundColor: Colors.lightBlueAccent,
      // ),
      //home: new MyApp(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        // 'login': (context) => const LoginScreen(),
        'register': (context) => const RegisterScreen(),
        'home': (context) => const Homepage(),
        'profile': (context) => const ProfilePage(),
        'about': (context) => const AboutsPage(),
        'search': (context) => const SearchPage(),
        'image': (context) => const ImagePage(),
        'editing': (context) => const EditingPage(),
        'cources': (context) => const Cources_Page(),
      },
    ),
  );
}
