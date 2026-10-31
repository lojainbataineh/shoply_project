import 'package:flutter/material.dart';
import 'package:shoply_app/core/dependencies/main/main_dependency.dart';

import 'features/app/view/shoply_app.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MainDependency.mainInitDependency();

  try {
    final doc = FirebaseFirestore.instance
        .collection('test')
        .doc('flutter_test');

    await doc.set({
      'message': 'Hello Firebase',
      'createdAt': FieldValue.serverTimestamp(),
    });

    print('Firestore Write: SUCCESS');

    final snapshot = await doc.get();

    print('Firestore Read: ${snapshot.data()}');
  } catch (e) {
    print('Firestore Error: $e');
  }

  runApp(const ShoplyApp());
}
