import 'package:flutter/material.dart';
//import 'package:quotes/ui/card/quotelist.dart';
import 'package:quotes/ui/sildeshow.dart';


class QuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      title: 'Story',
       theme: ThemeData.light(
        
       ),
      debugShowCheckedModeBanner: false,
      home: FirestoreSlideshow(),
      // routes: {
      //   '/': (context) => FirestoreSlideshow(),
      // //  '/login': (context) => LoginScreen(),
      // },
      );
  }
}