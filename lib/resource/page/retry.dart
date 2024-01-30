import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/resource/img_res.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class RetryPage extends StatelessWidget {
  RetryPage({Key? key, required this.retry}) : super(key: key);

  Function() retry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImgSrc.defaultEmpty,
            scale: 1.5,
          ).paddingOnly(bottom: 16),
          // V(16),
          Text(
            "Gagal mendapatkan data!",
            style: GoogleFonts.lato(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ).paddingOnly(bottom: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(
              color: Colors.green,
            )),
            onPressed: retry,
            child: Text(
              "Retry",
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
