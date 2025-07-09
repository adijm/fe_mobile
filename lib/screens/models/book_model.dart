class BookModel {
  final int id;
  final String title;
  final String author;
  final String publisher;
  final String publicationYear;
  final String categoryId;
  final String description;
  final String coverUrl;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.publisher,
    required this.publicationYear,
    required this.categoryId,
    required this.description,
    required this.coverUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      publisher: json['publisher'] ?? 'Unknown Publisher',
      publicationYear: json['publication_year']?.toString() ?? 'Unknown Year',
      categoryId: json['category_id']?.toString() ?? 'Unknown Category',
      description: json['description'] ?? 'No description available.',
      coverUrl: json['cover_url'] ?? '',
    );
  }
}