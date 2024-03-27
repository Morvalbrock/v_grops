import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [HexColor('2E87EB'), HexColor('368FF8')],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                height: 39,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      backgroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'login',
                    );
                  },
                  child: Text(
                    'Login',
                    style: GoogleFonts.getFont(
                      'Baloo Chettan 2',
                      color: const Color(0xFF33A9DB),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 0.07,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                width: 280,
                height: 39,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        0.0,
                      ), // Set to 0 for a square shape
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      'register',
                    );
                  },
                  child: Text(
                    'Register Now',
                    style: GoogleFonts.getFont(
                      'Baloo Chettan 2',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      height: 0.07,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
