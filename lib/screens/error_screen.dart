import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback? onPressed;
  const ErrorScreen({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/error.png',
              height: 120,
              width: 120,
            ),
            SizedBox(
              height: sHeight * 0.03,
            ),
            const Text(
              'Something went wrong',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: sHeight * 0.03,
            ),
            const Text(
              'Check your internet connection \n and try again',
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: sHeight * 0.05,
            ),
            ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Text(
                    'Try again',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
