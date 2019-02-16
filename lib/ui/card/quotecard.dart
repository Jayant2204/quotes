import 'package:flutter/material.dart';
import 'package:quotes/class/quote.dart';

class QuotesPreview extends StatelessWidget {
  final Quote quote;
  final bool inFavorites;
  final Function onFavoriteButtonPressed;

  QuotesPreview({
    @required this.quote,
    @required this.inFavorites,
    @required this.onFavoriteButtonPressed,
  });

  final LinearGradient backgroundGradient = new LinearGradient(colors: [
    new Color(0x10000000), // Light black
    new Color(0x30000000), // Dark black
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);

  RawMaterialButton _buildFavoriteButton() {
    return RawMaterialButton(
      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
      onPressed: () => onFavoriteButtonPressed(quote.id),
      child: Icon(
        // Conditional expression:
        // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
        inFavorites == true ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      elevation: 2.0,
      fillColor: Colors.transparent,
      shape: CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(25),
      child: new Material(
        borderRadius: new BorderRadius.circular(40.0),
        color: Colors.green,
        elevation: 10.0,
        shadowColor: Colors.black26,
        child: new Stack(
          children: <Widget>[
            new SizedBox.shrink(
              child: new Container(
                decoration: new BoxDecoration(
                  gradient: backgroundGradient,
                ),
              ),
            ),
            new Align(
              alignment: Alignment.center,
              child: new AspectRatio(
                aspectRatio: 1.0 / 1.0,
                child: Image.network(
                  quote.imageURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Positioned(
              child: _buildFavoriteButton(),
              top: 50.0,
              right: 10.0,
            ),
            new Align(
              alignment: Alignment.bottomLeft,
              child: new Material(
                borderRadius:
                    new BorderRadius.only(topRight: new Radius.circular(14.0)),
                color: Colors.black,
                child: new Container(
                  margin: new EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 12.0),
                  child: new Text(quote.quotetext,
                      style: new TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
