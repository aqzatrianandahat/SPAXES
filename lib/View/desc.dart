import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Desc extends StatefulWidget {
  const Desc({super.key});

  @override
  State<Desc> createState() => _DescState();
}

class _DescState extends State<Desc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 196, 196, 196),
      child: Center(
        child: Column(
          children: const [
            Text(
                "SPAXES adalah sebuah aplikasi media pembelajaran mengenai Luar Angkasa",
                style: TextStyle(
                  color: Color.fromARGB(255, 45, 50, 73),
                  fontFamily: 'Poppins SemiBold',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ))
          ],
        ),
      ),
    );
  }
}
