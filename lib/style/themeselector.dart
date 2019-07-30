import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes/style/themeChanger.dart';
import 'package:quotes/themes/themes.dart';

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
                 darkTheme(),
              ),
            ),
            FlatButton(
              child: Text('Light Theme'),
              onPressed: () => _themeChanger.setTheme(
                 lightTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  