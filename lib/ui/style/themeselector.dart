import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/ui/style/theme.dart';
import 'package:quotes/ui/style/colors.dart';

class ThemeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          
          children: <Widget>[
            FlatButton(
              child: Text('Dark Theme'),
              onPressed: () => _themeChanger.setTheme(
                 _darkTheme(),
              ),
            ),
            FlatButton(
              child: Text('Light Theme'),
              onPressed: () => _themeChanger.setTheme(
                 _lightTheme(),
              ),
            ),
          ],
        ),
      ),
    );
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

  ThemeData _lightTheme() {
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
}

  