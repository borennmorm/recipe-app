import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:recipe_app_sqflite/models/recipe_model.dart';

class Service {
  static const String baseUrl = 'https://dummyjson.com/recipes';

  Future<List<Recipe>> fetchRecipeData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<dynamic> data =
            jsonResponse['recipes']; // Assuming 'recipes' is the correct key
        List<Recipe> recipes =
            data.map((json) => Recipe.fromJson(json)).toList();
        return recipes;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }
}
