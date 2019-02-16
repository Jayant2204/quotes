import '../class/quote.dart';

List<Quote> getQuote() {
  return [
    Quote(id: '0',
    type: QuoteType.motivation,
    quotetext: 'Quote',
    imageURL: 'https://images.unsplash.com/photo-1528382324962-85858f70f39b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=667&q=80'
    ),

    Quote(id: '1',
    type: QuoteType.sucess,
    quotetext: 'Orange',
    imageURL: 'https://images.unsplash.com/photo-1532264043222-be99c0b73c8e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80'
    ),

    Quote(id: '2',
    type: QuoteType.motivation,
    quotetext: 'Shape',
    imageURL: 'https://images.unsplash.com/photo-1534237187820-7177d9bbd685?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80'
    ),

    Quote(id: '3',
    type: QuoteType.motivation,
    quotetext: 'Flower',
    imageURL: 'https://images.unsplash.com/photo-1464820453369-31d2c0b651af?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=80'
    ),
  ];
}

List<String> getFavoritesID() {
  return[
    '0',
    '1',
    '3',
  ];
}
