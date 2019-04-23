import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class FirestoreSlideshow extends StatefulWidget {
  createState() => FirestoreSlideshowState();
}

class FirestoreSlideshowState extends State<FirestoreSlideshow> {
  final PageController ctrl = PageController(viewportFraction: 0.8);

  final Firestore db = Firestore.instance;
  Stream slides;

  String activeTag = '';
  Color backgroundColor = Colors.white;
  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;
  bool _isfav = false;

// Icon configuration for NavBar.
  static double iconSize = 30;
  static Color iconColor = Colors.black45;

  @override
  void initState() {
    _queryDb();

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
    return StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          List slideList = snap.data.toList();

          return Scaffold(
            backgroundColor: Colors.white,
            body: PageView.builder(
                controller: ctrl,
                itemCount: slideList.length + 1,
                itemBuilder: (context, int currentIdx) {
                  if (currentIdx == 0) {
                    return _buildTagPage();
                  } else if (slideList.length >= currentIdx) {
                    // Active page
                    bool active = currentIdx == currentPage;
                    return _buildStoryPage(
                      slideList[currentIdx - 1],
                      active,
                    );
                  }
                }),
            bottomNavigationBar: _buildNavigationBar(),
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
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 24,
            right: 24,
            child: Material(
              elevation: 10,
              type: MaterialType.circle,
              color: Colors.transparent,
              child: Icon(
                _isfav ? Icons.favorite : Icons.favorite_border,
                color: _isfav ? Colors.redAccent : Colors.white,
                size: 30,
              ),
            ),
          ),
          Center(
              child: Text(
            data['title'],
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }

  _buildTagPage() {
    return Container(
        //color: Colors.white,
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Stories',
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
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
        Text('FILTER STORIES', style: TextStyle(color: Colors.black26)),
        _buildButton('favorites'),
        _buildButton('mountains'),
        _buildButton('road')
      ],
    ));
  }

  _buildButton(tag) {
    Color color = tag == activeTag ? Colors.purple[200] : Colors.white;
    return RaisedButton(
        color: color,
        elevation: tag == activeTag ? 5 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text('#$tag'),
        onPressed: () => _queryDb(tag: tag));
  }

  _buildNavigationBar() {
    return CurvedNavigationBar(
      backgroundColor: Colors.white,
      color: Colors.black12,
      height: 60,
      items: <Widget>[
        Icon(
          Icons.home,
          size: iconSize,
          color: iconColor,
        ),
        Icon(
          Icons.local_florist,
          size: iconSize,
          color: iconColor,
        ),
        Icon(
          Icons.settings,
          size: iconSize,
          color: iconColor,
        ),
        Icon(
          Icons.share,
          size: iconSize,
          color: iconColor,
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
