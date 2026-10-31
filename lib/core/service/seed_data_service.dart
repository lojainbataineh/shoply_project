import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shoply_app/core/utils/data/app_data.dart';

/// Uploads the sample data in `assets/data/` to Firestore the first time
/// the app runs against an empty database. Safe to call every launch.
class SeedDataService {
  static Future<void> seedIfNeeded() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final existing = await firestore.collection('Products').limit(1).get();
      if (existing.docs.isNotEmpty) return;

      final rawData = await rootBundle.loadString(AppData.sampleData);
      final data = jsonDecode(rawData) as Map<String, dynamic>;
      final batch = firestore.batch();

      for (final category in data['categories'] as List) {
        batch.set(
          firestore.collection('Categories').doc(category['id']),
          category,
        );
      }
      for (final product in data['products'] as List) {
        batch.set(firestore.collection('Products').doc(product['id']), product);
      }
      for (final sale in data['sales'] as List) {
        batch.set(firestore.collection('Sales').doc(sale['id']), sale);
      }

      await batch.commit();
      log('Sample data uploaded to Firestore.');
    } on FirebaseException catch (e) {
      log('Seeding sample data failed: ${e.message}');
    }
  }
}
