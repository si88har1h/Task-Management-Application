import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({required this.onChange, super.key});
  final void Function() onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/hero.jpg'),
              const SizedBox(
                height: 20,
              ),
              const Text.rich(
                TextSpan(
                    text: 'SSS ',
                    style: TextStyle(fontSize: 40),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Task management system',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color.fromARGB(255, 255, 115, 92)),
                      )
                    ]),
              ),
              const SizedBox(
                height: 90,
              ),
              ElevatedButton(
                onPressed: onChange,
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 50),
                    backgroundColor: const Color.fromARGB(255, 255, 115, 92)),
                child: const Text(
                  "Let's start",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ]),
      ),
    );
  }
}
