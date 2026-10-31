class ResponseSales {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? image;

  ResponseSales({
    required this.id,
    required this.image,
    this.title,
    this.subtitle,
  });

  factory ResponseSales.fromJson(Map<String, dynamic> json) {
    return ResponseSales(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
    );
  }
}
