import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:uas_mobile/Services/SpaxesServices.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Register",
                style: TextStyle(
                  color: Color.fromARGB(255, 45, 50, 73),
                  fontFamily: 'Poppins SemiBold',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 3),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Create your new account",
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Poppins Light',
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: controllerEmail,
              style: const TextStyle(
                fontFamily: 'Poppins Light',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Email",
                hintText: "Email",
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
              controller: controllerUsername,
              style: const TextStyle(
                fontFamily: 'Poppins Light',
                fontSize: 16,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Username",
                hintText: "Username",
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
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                var baseUrl = SpaxesService().baseUrlApi;

                var email = await Dio()
                    .get('$baseUrl/users?email=${controllerEmail.text}');
                var username = await Dio()
                    .get('$baseUrl/users?username=${controllerUsername.text}');
                // var password = await Dio()
                //     .get('$baseUrl/user?password=${controllerPassword.text}');

                if (username.data.length > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Username Already Exist"),
                  ));
                  controllerUsername.clear();
                  controllerEmail.clear();
                  controllerPassword.clear();
                } else if (email.data.length > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Email Already Exist"),
                  ));
                  controllerUsername.clear();
                  controllerEmail.clear();
                  controllerPassword.clear();
                } else {
                  var response = await Dio().post('$baseUrl/user', data: {
                    "username": controllerUsername.text,
                    "email": controllerEmail.text,
                    "password": controllerPassword.text
                  });

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }
              },
              child: const Text("SIGN UP",
                  style: TextStyle(
                    fontFamily: 'Poppins SemiBold',
                    fontSize: 18,
                  )),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 73, 79, 115),
                  minimumSize: const Size.fromHeight(55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                    style: TextStyle(
                      fontFamily: 'Poppins Light',
                      fontSize: 16,
                      color: Color.fromARGB(255, 73, 79, 115),
                    )),
                const SizedBox(width: 7),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Login(),
                    ));
                  },
                  child: const Text("Sign in",
                      style: TextStyle(
                        fontFamily: 'Poppins Light',
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
