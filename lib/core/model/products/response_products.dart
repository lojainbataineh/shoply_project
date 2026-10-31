class ResponseProducts {
  final String? id;
  final String? categoryId;
  final String? name;
  final String? description;
  final bool? isTrending;
  final double? price;
  final double? rating;
  final int? reviewsCount;
  final List<String> images;

  ResponseProducts({
    required this.id,
    required this.name,
    required this.description,
    required this.isTrending,
    required this.price,
    required this.images,
    this.categoryId,
    this.rating,
    this.reviewsCount,
  });

  String get firstImage => images.isNotEmpty ? images.first : '';

  factory ResponseProducts.fromJson(Map<String, dynamic> json) {
    final List<String> imagesData = [];
    for (var image in json['images'] ?? []) {
      imagesData.add(image);
    }
    return ResponseProducts(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      description: json['description'],
      isTrending: json['isTrending'],
      price: (json['price'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      images: imagesData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'isTrending': isTrending,
      'price': price,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'images': images,
    };
  }
}
