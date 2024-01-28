import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/extension.dart/dimens_extension.dart';
import 'package:flutter_starter_kit/resource/img_res.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColoredBox(
              color: Colors.teal,
              child: SizedBox(
                width: context.appWidth,
                child: Text(
                  "Hello, welcome to",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ).paddingOnly(bottom: kToolbarHeight),
            SizedBox(
              width: 150,
              child: Image.asset(
                ImgSrc.functionSun,
              ),
            ),
            Text(
              "Function Sun Corp Starter Kit",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ).paddingOnly(top: kToolbarHeight),
          ],
        ),
      ),
    );
  }
}
