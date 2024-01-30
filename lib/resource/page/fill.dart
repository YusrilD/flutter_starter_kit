import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/resource/img_res.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class FillPage extends StatelessWidget {
  FillPage({Key? key, required this.description}) : super(key: key);

  String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImgSrc.defaultFill,
            scale: 1.5,
          ).paddingOnly(bottom: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              description,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
