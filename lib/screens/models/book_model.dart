class BookModel {
  final int id;
  final String title;
  final String author;
  final String? publisher;
  final String? publicationYear;
  final String? categoryId;
  final String? description;
  final String? coverUrl;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    this.publisher,
    this.publicationYear,
    this.categoryId,
    this.description,
    this.coverUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    print("Parsing buku: ${json['title']}");

    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      publisher: json['publisher'],
      publicationYear: json['publication_year']?.toString(),
      categoryId: json['category_id']?.toString(),
      description: json['description']?.toString(),
      coverUrl: json['cover_url']?.toString(),
    );
  }
}
