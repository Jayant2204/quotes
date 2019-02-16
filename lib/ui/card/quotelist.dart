import 'package:flutter/material.dart';
import 'quotecard.dart';
import 'package:quotes/utils/store.dart';
import 'package:quotes/class/quote.dart';

class QuoteScrollPage extends StatefulWidget {
  @override
  _QuoteScrollPageState createState() => _QuoteScrollPageState();
}

class _QuoteScrollPageState extends State<QuoteScrollPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Color> bgColorAnimation;
  Animation<Color> iconColorAnimation;

  List<Quote> quote = getQuote();
  List<String> userFavorites = getFavoritesID();

  int actualQuote = 0;

  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);
    animationController.addListener(() => setState(() {}));

    bgColorAnimation =
        new ColorTween(begin: Colors.transparent, end: new Color(0xF04CAF50))
            .animate(new CurvedAnimation(
                parent: animationController, curve: Curves.decelerate));

    iconColorAnimation =
        new ColorTween(begin: Colors.transparent, end: Colors.white).animate(
      new CurvedAnimation(
          parent: animationController, curve: Curves.decelerate),
    );
  }

  void _handleFavoritesListChanged(String quoteID) {
    setState(() {
      if (userFavorites.contains(quoteID)) {
        userFavorites.remove(quoteID);
      } else {
        userFavorites.add(quoteID);
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Column _buildQuotes(List<Quote> quoteList) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              //itemCount: quoteList.length,
              itemBuilder: (BuildContext context, int index) {
                return new QuotesPreview(
                  quote: quoteList[index],
                  inFavorites: userFavorites.contains(quoteList[index].id),
                  onFavoriteButtonPressed: _handleFavoritesListChanged,
                );
              },
              onPageChanged: (int newQuotePos) => actualQuote = newQuotePos,
            ),
          ),
          new MaterialButton(
            onPressed: null,
            color: Colors.cyan,
            child: new Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('Share',
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600)),
            ),
          )
        ],
      );
    }

    return Material(
      borderRadius: new BorderRadius.circular(8.0),
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 3.0,
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text('Quotes',
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w700)),
              new Text('.',
                  style: new TextStyle(
                      color: Colors.green,
                      fontSize: 36.0,
                      fontWeight: FontWeight.w700))
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: new Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildQuotes(quote),            
          ],
        ),
      ),
    );
  }
}
