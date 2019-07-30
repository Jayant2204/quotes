import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'models.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

// Get Stream of document.
  Stream<List<QuoteType>> quoteType() {
    
    Stream stream = _db.collection('Category').snapshots().map((list) => list.documents.map((doc) => doc.data));
    
    return stream;
  }

   Stream<List<Quotes>> quotes (String quoteCategory) {
     // Make a Query
    Query query = _db.collection('Quotes').where('category', isEqualTo: quoteCategory).limit(10);

    // Map the documents to the data payload
    Stream slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    return slides;
   }

}
