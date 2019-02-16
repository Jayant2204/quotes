enum QuoteType{
motivation,
sucess,
}


class Quote  {
  final String id;
  final QuoteType type;
  final String quotetext;
  final String imageURL;

  const Quote({
    this.id,
    this.type,
    this.quotetext,
    this.imageURL,
  });
}