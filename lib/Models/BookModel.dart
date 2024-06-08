class BookModel {
  String? id;
  String? title;
  String? description;
  String? rating;
  int? pages;
  String? language;
  String? audioLen;
  String? author;
  String? aboutAuthor;
  String? bookurl;
  String? audioUrl;
  String? category;
  String? coverUrl;
  int? price;
  int? numberofRating; // Ubah tipe data menjadi int

  BookModel({
    this.id,
    this.title,
    this.description,
    this.rating,
    this.pages,
    this.language,
    this.audioLen,
    this.author,
    this.aboutAuthor,
    this.bookurl,
    this.audioUrl,
    this.category,
    this.coverUrl,
    this.price,
    this.numberofRating, // Pastikan parameter ini ada
  });

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    rating = json["rating"];
    pages = json["pages"];
    language = json["language"];
    audioLen = json["audioLen"];
    author = json["author"];
    aboutAuthor = json["aboutAuthor"];
    bookurl = json["bookurl"];
    audioUrl = json["audioUrl"];
    category = json["category"];
    coverUrl = json["coverUrl"];
    price = json["price"];
    numberofRating = json["numberofRating"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["rating"] = rating;
    data["pages"] = pages;
    data["language"] = language;
    data["audioLen"] = audioLen;
    data["author"] = author;
    data["aboutAuthor"] = aboutAuthor;
    data["bookurl"] = bookurl;
    data["audioUrl"] = audioUrl;
    data["category"] = category;
    data["coverUrl"] = coverUrl;
    data["price"] = price;
    data["numberofRating"] = numberofRating;
    return data;
  }
}
