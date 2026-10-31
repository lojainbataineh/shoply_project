import 'package:flutter_test/flutter_test.dart';
import 'package:shoply_app/core/helper/date_helper.dart';
import 'package:shoply_app/core/model/products/response_products.dart';
import 'package:shoply_app/core/regex/app_regex.dart';

void main() {
  test('ResponseProducts parses Firestore data', () {
    final product = ResponseProducts.fromJson({
      'id': 'p90',
      'categoryId': 'shoes',
      'name': 'Puma Future Rider Trainers',
      'price': 90,
      'images': ['a.webp', 'b.webp'],
      'isTrending': true,
    });
    expect(product.price, 90.0);
    expect(product.firstImage, 'a.webp');
    expect(product.categoryId, 'shoes');
  });

  test('Password validation', () {
    expect(AppRegex.validatePassword('short'), isNotNull);
    expect(AppRegex.validatePassword('longpassword'), isNotNull);
    expect(AppRegex.validatePassword('Password@1'), isNull);
  });

  test('Date format', () {
    expect(DateHelper.formatDate(DateTime(2026, 10, 15)), 'Oct 15, 2026');
  });
}
