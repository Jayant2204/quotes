import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:quotes/style/themeChanger.dart';
import 'package:provider/provider.dart';

class ShowQuotes extends StatefulWidget {
  @override
  _ShowQuotesState createState() => _ShowQuotesState();
}

class _ShowQuotesState extends State<ShowQuotes> {
  
  
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    ThemeData themeData = theme.getTheme();
    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      
      
    );
  }
}