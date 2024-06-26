import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app_sqflite/views/recipe_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: RecipeList());
  }
}
