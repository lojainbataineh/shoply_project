import 'package:flutter/material.dart';
import 'package:shoply_app/core/dependencies/firebase/firebase_dependency.dart';
import 'package:shoply_app/core/dependencies/local_storage/local_storage_dependency.dart';
import 'package:shoply_app/core/dependencies/supabase/supabase_dependency.dart';

class MainDependency {
  static Future<void> mainInitDependency() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageDependency.initloaclStoradeDependency();
    await FirebaseDependency.inttFirebaseDependency();
    await SupabaseDependency.supabaseInitDependency();
  }
}
