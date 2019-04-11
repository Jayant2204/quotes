import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';

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

  // Circular Bottom Navigation fields
  int selectedPos = 0;
  CircularBottomNavigationController _navigationController;
  

  @override
  void initState() {
    _queryDb();

    // Circular Bottom Navigation fields
    _navigationController = new CircularBottomNavigationController(selectedPos);

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
    double pageheight = MediaQuery.of(context).size.height;

    List<TabItem> tabItems = List.of([
      new TabItem(Icons.home, "Home", Colors.blue),
      new TabItem(Icons.search, "Search", Colors.orange),
      new TabItem(Icons.layers, "Reports", Colors.red),
      new TabItem(Icons.notifications, "Notifications", Colors.cyan),
    ]);

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
                        slideList[currentIdx - 1], active, pageheight);
                  }
                }),
            bottomNavigationBar: CircularBottomNavigation(
              tabItems,
               controller: _navigationController,
            ),
          );
        });
  }

  Stream _queryDb({String tag}) {
    // Make a Query
    Query query =
        db.collection('Stories'); //.where('tags', arrayContains: tag);

    // Map the documents to the data payload
    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    // Update the active tag
    setState(() {
      activeTag = tag;
    });
  }

  // Builder Functions

  _buildStoryPage(Map data, bool active, double height) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;
    
    // CachedNetworkImage image  = CachedNetworkImage(
    //   imageUrl: data['img'],
    //   placeholder: (context, url) => CircularProgressIndicator(),
    //   errorWidget: (context, url, error) => new Icon(Icons.error),
    // ); 
    //cannot use as per current build using animated containers
    
    return AnimatedContainer(
      height: height,
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
          inherit: false,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      )),
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
              fontSize: 40,
              fontWeight: FontWeight.bold,
              inherit: false,
              color: Colors.black),
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
        Text('FILTER STORIES',
            style: TextStyle(inherit: false, color: Colors.black26)),
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

    @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}


