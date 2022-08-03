import 'package:flutter/material.dart';
import 'package:notary_app/custom_colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: error_page_background_color,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Image.asset(
                'Assets/images/ice.png',
                height: _height * .23,
              ),
            ),
            Text(
              "Oops...",
              style: logintextstyle.copyWith(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _height * .02,
            ),
            Text(
              "There is a connection error. Please check your \n internet and try again",
              style: logintextstyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: _height * .03,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Try Again")),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
