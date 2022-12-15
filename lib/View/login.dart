import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Services/SpaxesServices.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 196, 196),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 23),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: const <Widget>[
                  Text(
                    "Welcome To SPAXES",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins SemiBold',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 3),
                  Image(
                      image: AssetImage("assets/images/Logo Name.png"),
                      fit: BoxFit.fill),
                  SizedBox(height: 3),
                  Text("Login to your account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Poppins Light',
                      )),
                ],
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: controllerUsername,
              style: const TextStyle(
                fontFamily: 'Poppins Light',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Email Address",
                hintText: "Email Address",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins Light',
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              obscureText: true,
              controller: controllerPassword,
              style: const TextStyle(
                fontFamily: 'Poppins Light',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Password",
                hintText: "Password",
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins Light',
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                "Forgot password?",
                style: TextStyle(
                  color: Color.fromARGB(255, 73, 79, 115),
                  fontSize: 16,
                  fontFamily: 'Poppins Light',
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                var baseUrl = SpaxesService().baseUrlApi;
                String usernamez, emailz, passwordz;
                int id;

                var username = await Dio()
                    .get('$baseUrl/users?username=${controllerUsername.text}');
                var email = await Dio()
                    .get('$baseUrl/users?email=${controllerUsername.text}');
                var password = await Dio()
                    .get('$baseUrl/users?password=${controllerPassword.text}');

                if (username.data.length > 0) {
                  if (password.data.length > 0) {
                    id = username.data[0]['id'];

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Password Salah"),
                    ));
                    controllerUsername.clear();

                    controllerPassword.clear();
                  }
                } else if (email.data.length > 0) {
                  if (password.data.length > 0) {
                    id = email.data[0]['id'];

                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Password Salah"),
                    ));
                    controllerUsername.clear();

                    controllerPassword.clear();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Email atau Username Salah"),
                  ));
                  controllerUsername.clear();

                  controllerPassword.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 73, 79, 115),
                  minimumSize: const Size.fromHeight(55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              child: const Text("SIGN IN",
                  style: TextStyle(
                    fontFamily: 'Poppins SemiBold',
                    fontSize: 18,
                  )),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?",
                    style: TextStyle(
                      fontFamily: 'Poppins Light',
                      fontSize: 16,
                      color: Color.fromARGB(255, 73, 79, 115),
                    )),
                const SizedBox(width: 7),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //   builder: (context) => const Register(),
                    // ));
                  },
                  child: const Text("Sign up",
                      style: TextStyle(
                        fontFamily: 'Poppins SemiBold',
                        fontSize: 16,
                        color: Color.fromARGB(255, 45, 50, 73),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
