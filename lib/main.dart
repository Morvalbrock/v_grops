import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:v_group/aboutspage.dart';
import 'package:v_group/classes/language_constants.dart';
import 'package:v_group/courses_page.dart';
import 'package:v_group/donation_page.dart';
import 'package:v_group/editing_page.dart';
import 'package:v_group/home.dart';
import 'package:v_group/imagepage.dart';
import 'package:v_group/loginscreen.dart';
import 'package:v_group/profilepage.dart';
import 'package:v_group/registerpage.dart';
import 'package:v_group/searchpage.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var KColorScheme = ColorScheme.fromSeed(
  seedColor: HexColor('025CAF'),
);
void main() {
  runApp(
      // MaterialApp(
      //   debugShowCheckedModeBanner: false,

      //   localizationsDelegates: AppLocalizations.localizationsDelegates,
      //   supportedLocales: AppLocalizations.supportedLocales,

      //   // locale: Locale('ta'),
      //   initialRoute: '/',
      //   routes: {
      //     '/': (context) => const LoginScreen(),
      //     // 'login': (context) => const LoginScreen(),
      //     'register': (context) => const RegisterScreen(),
      //     'home': (context) => const Homepage(),
      //     'profile': (context) => const ProfilePage(),
      //     'about': (context) => const AboutsPage(),
      //     'search': (context) => const SearchPage(),
      //     'image': (context) => const ImagePage(),
      //     'editing': (context) => const EditingPage(),
      //     'cources': (context) => const Cources_Page(),
      //   },

      // ),
      MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      print(_locale);
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Localization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        // 'login': (context) => const LoginScreen(),
        'register': (context) => const RegisterScreen(),
        'home': (context) => const Homepage(),
        'profile': (context) => const ProfilePage(),
        'about': (context) => AboutsPage(_locale!),
        'books': (context) => SearchPage(_locale!),
        'image': (context) => const ImagePage(),
        'editing': (context) => const EditingPage(),
        'cources': (context) => const Cources_Page(),
        'donation': (context) => const DonationPage(),
      },
    );
  }
}
