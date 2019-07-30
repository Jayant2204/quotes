import 'package:cloud_firestore/cloud_firestore.dart';

class Quotes {
final String category ;
final String imgurl ; 
final String quotetext ;
final String documentId;

Quotes ({this.category, this.imgurl, this.quotetext, this.documentId});

factory Quotes.fromFirestore(DocumentSnapshot doc) {
  Map data = doc.data;

  return Quotes(
    documentId: doc.documentID,
    category: data['category'] ?? '',
    imgurl: data['imgurl'] ?? '' ,
    quotetext: data['quotetext'] ?? '' ,
  );
}
}

class QuoteType {
  final String id;
  final String name;
  final String imageurl;

  QuoteType({this.id, this.name, this.imageurl});

  factory QuoteType.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data ;
    return QuoteType(
    id: doc.documentID,
    name: data['name'],
    imageurl: data['imageurl']);
  }
}