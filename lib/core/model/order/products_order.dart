import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply_app/core/model/cart/cart.dart';

class ProductsOrder {
  String? id;
  final String? userUid;
  final String? fullName;
  final String? address;
  final double? subTotal;
  final String? status;
  final List<Cart>? cart;
  final DateTime? createdAt;

  ProductsOrder({
    this.id,
    required this.userUid,
    required this.fullName,
    required this.address,
    required this.subTotal,
    required this.cart,
    required this.status,
    this.createdAt,
  });

  String get orderNumber => (id ?? '').length >= 6
      ? id!.substring(0, 6).toUpperCase()
      : (id ?? '').toUpperCase();

  int get itemsCount {
    int count = 0;
    for (final item in cart ?? <Cart>[]) {
      count += item.quantity ?? 0;
    }
    return count;
  }

  factory ProductsOrder.fromJson(Map<String, dynamic> json) {
    final List<Cart> cartData = [];
    for (var cart in json['cart'] ?? []) {
      cartData.add(Cart.fromJson(Map<String, dynamic>.from(cart)));
    }
    final createdAt = json['createdAt'];
    return ProductsOrder(
      id: json['id'],
      userUid: json['userUid'],
      fullName: json['fullName'],
      address: json['address'],
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      status: json['status'],
      cart: cartData,
      createdAt: createdAt is Timestamp ? createdAt.toDate() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userUid': userUid,
      'fullName': fullName,
      'address': address,
      'subTotal': subTotal,
      'status': status,
      'cart': cart?.map((cart) => cart.toJson()).toList(),
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
