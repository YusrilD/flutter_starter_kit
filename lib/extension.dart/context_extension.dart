import 'package:flutter/material.dart';

extension CustomTextTheme on BuildContext {
  TextStyle get customHeadline6 => Theme.of(this).textTheme.headline6!.copyWith(
        fontFamily: 'YourCustomFont',
      );
}




    // Headlines:
    //     headline1
    //     headline2
    //     headline3
    //     headline4
    //     headline5
    //     headline6

    // Subtitles:
    //     subtitle1
    //     subtitle2

    // Body Texts:
    //     bodyText1
    //     bodyText2

    // Other Styles:
    //     caption: Used for small text that complements other content.
    //     button: Used for text on buttons.
    //     overline: A very small style for additional information.