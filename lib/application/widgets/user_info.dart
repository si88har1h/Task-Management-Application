import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sss/utils/styles.dart' as styles;

class UserInfo extends StatelessWidget {
  const UserInfo(
      {required this.username, required this.navigationFunction, super.key});

  final void Function() navigationFunction;
  final dynamic username;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back!',
              style: TextStyle(color: Color.fromARGB(255, 255, 115, 92)),
            ),
            Text(
              username,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                navigationFunction();
                styles.customSnackBar(context, 'Logged out!');
              },
              icon: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 255, 115, 92),
              ),
            ),
          ],
        )
      ],
    );
  }
}
