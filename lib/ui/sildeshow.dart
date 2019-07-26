import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:quotes/ui/style/themeselector.dart';
import 'package:provider/provider.dart';
import 'package:quotes/ui/style/theme.dart';

class Slideshow extends StatefulWidget {
  createState() => SlideshowState();
}

class SlideshowState extends State<Slideshow> {
  final PageController ctrl = PageController(viewportFraction: 0.8);

  final Firestore db = Firestore.instance;
  Stream slides;
  
  String activeTag = '';
  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;

  @override
  void initState() {
    _queryDb();
  super.initState();
    // Circular Bottom Navigation fields

    // Set state when page changes
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    ThemeData themeData = theme.getTheme();
    return StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          List slideList = snap.data.toList();

          return Scaffold(
            backgroundColor: themeData.scaffoldBackgroundColor,
            body: PageView.builder(
                controller: ctrl,
                itemCount: slideList.length + 1,
                itemBuilder: (BuildContext context, int currentIdx) {
                  if (currentIdx == 0) {
                    return _buildTagPage(themeData);
                  } else if (slideList.length >= currentIdx) {
                    // Active page
                    bool active = currentIdx == currentPage;
                    return _buildStoryPage(
                      slideList[currentIdx - 1],
                      active,
                    );
                  }
                }),
            bottomNavigationBar: _buildNavigationBar(themeData),
          );
        });
  }

  Stream _queryDb({String tag}) {
    // Make a Query
    Query query = db.collection('Stories').where('tags', arrayContains: tag);

    // Map the documents to the data payload
    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    // Update the active tag
    setState(() {
      activeTag = tag;
    });
  }

  // Builder Functions

  _buildStoryPage(
    Map data,
    bool active,
  ) {
    // Animated Properties
    final double blur = active ? 20 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(data['img']),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
      child: Center(
          child: Text(
        data['title'],
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),),
    );
  }

  _buildTagPage(ThemeData themeData) {
    return Container(
        color: themeData.scaffoldBackgroundColor,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Stories',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: themeData.textTheme.headline.color),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          color: Colors.grey[300],
          height: 2,
          width: 100,
        ),
        SizedBox(
          height: 25,
        ),
        Text('FILTER QUOTES', style: TextStyle(color: themeData.dividerColor,),),
        _buildButton('favorites' , themeData),
        _buildButton('mountains' , themeData),
        _buildButton('road' , themeData),

        IconButton(
          color: themeData.iconTheme.color,
          icon: Icon(Icons.invert_colors),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ThemeSelector()));
          },

        )

      ],
    ));
  }

  _buildButton(tag , ThemeData themeData) {
    bool currentTag = tag == activeTag ;
    Color color = currentTag ? Colors.purple[200] : themeData.cardColor;
    return RaisedButton(
        color: color,
        elevation: currentTag ? 5 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text('#$tag'),
        onPressed: () => _queryDb(tag: tag));
  }

  _buildNavigationBar(ThemeData themeData) {
    return CurvedNavigationBar(
      backgroundColor: themeData.cardColor,
      color: themeData.bottomAppBarColor,
      height: 60,
      items: <Widget>[
        Icon(
          Icons.home,
          size: themeData.iconTheme.size,
          color: themeData.iconTheme.color,
        ),
        Icon(
          Icons.local_florist,
          size: themeData.iconTheme.size,
          color: themeData.iconTheme.color,
        ),
        Icon(
          Icons.settings,
          size: themeData.iconTheme.size,
          color: themeData.iconTheme.color,
        ),
        Icon(
          Icons.share,
          size: themeData.iconTheme.size,
          color: themeData.iconTheme.color,
        ),
      ],
      onTap: (index) {
        //Handle button tap
        switch (index) {
          case 0:
            {
             
            }
        }
      },
    );
  }
}
