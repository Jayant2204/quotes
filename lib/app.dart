import 'package:flutter/material.dart';
import 'package:quotes/ui/sildeshow.dart';
import 'package:quotes/ui/style/theme.dart';
import 'package:provider/provider.dart';
import 'package:quotes/ui/style/colors.dart';

class QuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChanger>(
          builder: (_) => ThemeChanger(
            _darkTheme(),
          ),
        ),
      ],
      //returns a ThemeChanger that uses the ThemeData.dark() factory to generate a dark theme by default
      child: new MaterialAppWithTheme(),
      //Extract The Widget to a new Widget so that ThemeChanger can be used using Provider.of():
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      title: 'Story',
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
      home: Slideshow(),
    );
  }
}

ThemeData _darkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      accentColor: kDarkGrey,
      primaryColor: kDarkGrey,
      brightness: Brightness.dark,
      bottomAppBarColor: Colors.white24,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: kYellow,
        textTheme: ButtonTextTheme.normal,
      ),
      iconTheme: base.iconTheme.copyWith(
        color: kYellow,
        size: 30.0,
      ),
      scaffoldBackgroundColor: kDarkGrey,
      cardColor: kDarkGrey,
      textSelectionColor: kCyan,
      errorColor: kErrorRed,
      textTheme: darkTextTheme(base.textTheme),
      primaryTextTheme: darkTextTheme(base.primaryTextTheme),
      accentTextTheme: darkTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(color: kYellow),
      cursorColor: kYellow,
      textSelectionHandleColor: kSurfaceWhite.withAlpha(153),
      dividerColor: kBackgroundWhite.withOpacity(0.5));
}

TextTheme darkTextTheme(TextTheme base) {
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
        displayColor: kSurfaceWhite,
        bodyColor: kSurfaceWhite,
      );
}
