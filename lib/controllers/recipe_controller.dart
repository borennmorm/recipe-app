import 'package:get/get.dart';
import 'package:recipe_app_sqflite/models/recipe_model.dart';
import 'package:recipe_app_sqflite/services/service.dart';

class RecipeController extends GetxController {
  var isLoading = true.obs;
  var recipes = <Recipe>[].obs;

  final Service _service = Service();

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  void fetchRecipes() async {
    try {
      isLoading(true);
      var fetchedRecipes = await _service.fetchRecipeData();
      recipes.assignAll(fetchedRecipes);
    } catch (e) {
      print('Error fetching recipes: $e');
    } finally {
      isLoading(false);
    }
  }
}
