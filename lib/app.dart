import 'package:flutter/material.dart';
import 'package:quotes/ui/card/quotelist.dart';


class QuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      title: 'Recipes',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      
      routes: {
        '/': (context) => QuoteScrollPage(),
      //  '/login': (context) => LoginScreen(),
      },
      );
  }
}