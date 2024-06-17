import 'dart:convert';

import 'package:Sivayogi_The_Guru/loginscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

TextEditingController _firstname = TextEditingController();
TextEditingController _lastname = TextEditingController();
TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

Future<void> register(String name, String lastname, String email,
    String password, context) async {
  final uri = Uri.parse('https://vgroups-api.pharma-sources.com/api/user/');
  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'first_name': name,
        'last_name': lastname,
        'email': email,
        'password': password,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: 'Register succssfully....',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: 'Register succssfully....',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      print('A network error occurred');
      print(response.statusCode);
      Fluttertoast.showToast(
          msg: 'enter valid  password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pushNamed("register");
    }
  } catch (error) {
    // ignore: avoid_print
    print('Error: $error');
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/images/piclogin.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.20,
                  ),
                  const Text(
                    'First name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Baloo Chettan 2',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      // validator: validateName,
                      controller: _firstname,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        hintText: 'Enter your name here',

                        hintStyle: TextStyle(
                          color: HexColor('4E4E4E'),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.01,
                        ),
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 10, horizontal: 20.0),
                        errorBorder: InputBorder.none,

                        filled: true,
                        fillColor: const Color.fromARGB(241, 241, 241, 241),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    'Last Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Baloo Chettan 2',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      // validator: validateName,
                      controller: _lastname,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        hintText: 'Enter confirm password here',

                        hintStyle: TextStyle(
                          color: HexColor('4E4E4E'),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.01,
                        ),
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 10, horizontal: 20.0),
                        errorBorder: InputBorder.none,

                        filled: true,
                        fillColor: const Color.fromARGB(241, 241, 241, 241),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    'Email id',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Baloo Chettan 2',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      // validator: validateName,
                      controller: _email,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        hintText: 'Enter your email here',

                        hintStyle: TextStyle(
                          color: HexColor('4E4E4E'),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.01,
                        ),
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 10, horizontal: 20.0),
                        errorBorder: InputBorder.none,

                        filled: true,
                        fillColor: const Color.fromARGB(241, 241, 241, 241),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Baloo Chettan 2',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      // validator: validateName,
                      controller: _password,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        hintText: 'Enter your password here',

                        hintStyle: TextStyle(
                          color: HexColor('4E4E4E'),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.01,
                        ),
                        // contentPadding: EdgeInsets.symmetric(
                        //     vertical: 10, horizontal: 20.0),
                        errorBorder: InputBorder.none,

                        filled: true,
                        fillColor: const Color.fromARGB(241, 241, 241, 241),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // foregroundColor: HexColor('81D6FB'),
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      onPressed: () {
                        register(
                          _firstname.text,
                          _lastname.text,
                          _email.text,
                          _password.text,
                          context,
                        );
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          color: Color(0xFF0962B8),
                          fontSize: 20,
                          fontFamily: 'Baloo Chettan 2',
                          fontWeight: FontWeight.w600,
                          height: 0.07,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.05,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account ? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'Baloo Chettan 2',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Baloo Chettan 2',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
