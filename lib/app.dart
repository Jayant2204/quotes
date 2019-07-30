import 'package:flutter/material.dart';
import 'package:quotes/class/db.dart';
import 'package:quotes/class/models.dart';
import 'package:quotes/ui/sildeshow.dart';
import 'package:quotes/style/themechanger.dart';
import 'package:provider/provider.dart';
import 'package:quotes/themes/dark.dart';


class QuotesApp extends StatelessWidget {
  final db = DatabaseService();
  final quoteCategory = '' ;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //returns a ThemeChanger that uses the ThemeData.dark() factory to generate a dark theme by default
        ChangeNotifierProvider<ThemeChanger>.value(
          value: ThemeChanger(
            darkTheme(),
          ),
        ),
        //Stream Provider returning List of all the category of Quotes used on HomePage.
        //Here Value is used instead of builder due to changes in provider package v3.
        StreamProvider<List<QuoteType>>.value(  
          value: db.quoteType(),
          ),

        // New StreamProvider for Quotes list.
        StreamProvider<List<Quotes>>.value(
          value: db.quotes(quoteCategory),
        ),
      ],
      
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