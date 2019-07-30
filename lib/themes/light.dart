import 'package:flutter/material.dart';
import 'package:quotes/style/colors.dart';


  lightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
        accentColor: kBrown900,
        primaryColor: kCyan,
        brightness: Brightness.light,
        bottomAppBarColor: Colors.black26,
        buttonTheme: base.buttonTheme.copyWith(
          buttonColor: kCyan,
          textTheme: ButtonTextTheme.normal,
        ),
        iconTheme: base.iconTheme.copyWith(
          color: kCyan,
          size: 30.0,
        ),
        scaffoldBackgroundColor: kBackgroundWhite,
        cardColor: kBackgroundWhite,
        textSelectionColor: kCyan,
        errorColor: kErrorRed,
        textTheme: lightTextTheme(base.textTheme),
        primaryTextTheme: lightTextTheme(base.primaryTextTheme),
        accentTextTheme: lightTextTheme(base.accentTextTheme),
        primaryIconTheme: base.iconTheme.copyWith(
          color: kBrown900,
        ),
        cursorColor: kBrown900,
        textSelectionHandleColor: kBrown900.withAlpha(153),
        dividerColor: kBrown900.withOpacity(0.8));
  }

  TextTheme lightTextTheme(TextTheme base) {
    return base
        .copyWith(
          headline: base.headline.copyWith(
            fontWeight: FontWeight.w500,
          ),
          title: base.title.copyWith(fontSize: 18.0),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
        )
        .apply(
          fontFamily: 'Rubik',
          displayColor: kBrown900,
          bodyColor: kBrown900,
        );
  }