import 'package:flutter/material.dart';
import 'package:quotes/ui/sildeshow.dart';
import 'package:quotes/ui/Pages/loginpage.dart';


class QuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      title: 'Story',
       theme: ThemeData.light(
        
       ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),//FirestoreSlideshow(),
      // routes: {
      //   '/': (context) => FirestoreSlideshow(),
      // //  '/login': (context) => LoginScreen(),
      // },
      );
  }
}