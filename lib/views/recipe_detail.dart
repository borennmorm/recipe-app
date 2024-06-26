import 'package:flutter/material.dart';
import 'package:recipe_app_sqflite/models/recipe_model.dart';

class RecipeDetail extends StatelessWidget {
  final Recipe recipe;

  // Constructor to receive the recipe object
  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the recipe image if it's available
            if (recipe.image.isNotEmpty)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      8.0), // Round the corners of the image
                  child: Image.network(
                    recipe.image, // Load image from the network
                    fit: BoxFit.cover, // Cover the entire aspect ratio box
                  ),
                ),
              ),
            const SizedBox(height: 16), // Add some space
            _buildRatingRow(), // Display the rating row
            const SizedBox(height: 8), // Add some space
            _buildDetailItem(
                'Difficulty', recipe.difficulty), // Display the difficulty
            _buildDetailItem(
                'Servings', recipe.servings.toString()), // Display the servings
            _buildDetailItem('Cook Time',
                '${recipe.cookTimeMinutes} mins'), // Display the cook time
            const SizedBox(height: 16), // Add some space
            _buildSectionTitle(
                'Ingredients'), // Display the ingredients section title
            _buildListItems(recipe.ingredients), // Display the ingredients list
            const SizedBox(height: 16), // Add some space
            _buildSectionTitle(
                'Instructions'), // Display the instructions section title
            _buildListItems(
                recipe.instructions), // Display the instructions list
          ],
        ),
      ),
    );
  }

  // Method to build the rating row
  Widget _buildRatingRow() {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 24), // Star icon
        const SizedBox(width: 4), // Add some space
        Text(
          recipe.rating.toString(), // Display the rating
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8), // Add some space
        Text(
          '(${recipe.reviewCount})', // Display the review count
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  // Method to build detail items like difficulty, servings, and cook time
  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$label: ',
            style: const TextStyle(
                fontSize: 18, color: Colors.black), // Label style
            children: [
              TextSpan(
                text: value, // Value text
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _getDifficultyColor(
                      value), // Use the method to get color based on value
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

// Method to determine the color based on difficulty value
  Color _getDifficultyColor(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.amber;
      case 'hard':
        return Colors.red;
      default:
        return Colors.black; // Default color if difficulty is unknown
    }
  }

  // Method to build section titles like "Ingredients" and "Instructions"
  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title, // Display the section title
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8), // Add some space
      ],
    );
  }

  // Method to build a list of items like ingredients or instructions
  Widget _buildListItems(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  '- $item', // Display each item with a bullet point
                  style: const TextStyle(fontSize: 16),
                ),
              ))
          .toList(),
    );
  }
}
