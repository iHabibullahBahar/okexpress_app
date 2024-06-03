import 'dart:convert';

import 'package:get/get.dart';
import 'package:okexpress/src/common/models/ingredient_model.dart';
import 'package:okexpress/src/common/models/recipe_details_model.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/helper/api_services.dart';
import 'package:okexpress/src/utils/api_urls.dart';
import 'package:okexpress/src/utils/colors.dart';

class CommonController extends GetxController {
  static CommonController get instance => Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  RecipeDetailsModel recipeDetailsModel = RecipeDetailsModel();
  RxBool isRecipeDetailsFetching = false.obs;
  RxBool isSwappableIngredientsFetching = false.obs;
  fetchRecipeDetails({
    required int recipeId,
    bool generatedRecipe = false,
  }) async {
    try {
      var requestBody = {
        "id": recipeId,
        "generated_recipe": generatedRecipe,
      };
      isRecipeDetailsFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zShowRecipeDetailEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        recipeDetailsModel = RecipeDetailsModel.fromJson(decoded);
        isRecipeDetailsFetching.value = false;
      } else {
        if (decoded['success'] == false) {
          Get.snackbar(
            'Error',
            decoded['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zWhiteColor,
            duration: const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: zErrorSwatch,
        colorText: zWhiteColor,
        duration: const Duration(seconds: 2),
      );
    }
    isRecipeDetailsFetching.value = false;
  }

  RxBool isRecipeToggling = false.obs;
  Future<bool> toggleFavRecipe({required int recipeId}) async {
    try {
      var requestBody = {
        "recipe_id": recipeId,
      };
      isRecipeToggling.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zToggleFavoriteRecipeEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        isRecipeToggling.value = false;
        return true;
      } else {
        if (decoded['success'] == false) {
          CustomSnackBarService()
              .showErrorSnackBar(message: "Failed to toggle favorite");
        }
        isRecipeToggling.value = false;
        return false;
      }
    } catch (e) {
      CustomSnackBarService()
          .showErrorSnackBar(message: "Failed to toggle favorite");
    }
    isRecipeToggling.value = false;
    return false;
  }

  IngredientModel ingredientModel = IngredientModel();
  Future<bool> showSwappableIngredients(
      {required int recipeId, required int rootIngredientId}) async {
    try {
      var requestBody = {
        "recipe_id": recipeId,
        "root_ingredient_id": rootIngredientId,
      };
      isSwappableIngredientsFetching.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zShowSwappableIngredientsEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        ingredientModel = IngredientModel.fromJson(decoded);
        isSwappableIngredientsFetching.value = false;
        return true;
      } else {
        if (decoded['success'] == false) {
          Get.snackbar(
            'Error',
            decoded['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zWhiteColor,
            duration: const Duration(seconds: 2),
          );
        }
        isSwappableIngredientsFetching.value = false;
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: zErrorSwatch,
        colorText: zWhiteColor,
        duration: const Duration(seconds: 2),
      );
    }
    isSwappableIngredientsFetching.value = false;
    return false;
  }

  RxBool isSwappingIngredients = false.obs;
  Future<bool> swapIngredient(
      {required int generatedRecipeId,
      required int rootIngredientId,
      required int chosenIngredientId}) async {
    try {
      var requestBody = {
        "generated_recipe_id": generatedRecipeId,
        "root_ingredient_id": rootIngredientId,
        "chosen_ingredient_id": chosenIngredientId,
      };
      isSwappingIngredients.value = true;
      var response = await ApiServices.instance.getResponse(
        requestBody: requestBody,
        endpoint: zSwapIngredientEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        ingredientModel = IngredientModel.fromJson(decoded);
        isSwappingIngredients.value = false;
        return true;
      } else {
        if (decoded['success'] == false) {
          Get.snackbar(
            'Error',
            decoded['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: zErrorSwatch,
            colorText: zWhiteColor,
            duration: const Duration(seconds: 2),
          );
        }
        isSwappingIngredients.value = false;
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: zErrorSwatch,
        colorText: zWhiteColor,
        duration: const Duration(seconds: 2),
      );
    }
    isSwappableIngredientsFetching.value = false;
    return false;
  }

  Future<bool> generateMeals() async {
    try {
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        endpoint: zGenerateMealsEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        if (decoded['success'] == false) {
          CustomSnackBarService()
              .showErrorSnackBar(message: "Failed to generate meals");
        }
        return false;
      }
    } catch (e) {
      CustomSnackBarService()
          .showErrorSnackBar(message: "Failed to generate meals");
    }
    return false;
  }

  Future<bool> generateNewMeals() async {
    try {
      var response = await ApiServices.instance.getResponse(
        requestBody: {},
        endpoint: zGenerateNewMealsEndpoint,
        isAuthToken: true,
      );
      var decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        if (decoded['success'] == false) {
          CustomSnackBarService()
              .showErrorSnackBar(message: "Failed to generate new meals");
        }
        return false;
      }
    } catch (e) {
      CustomSnackBarService()
          .showErrorSnackBar(message: "Failed to generate new meals");
    }
    return false;
  }
}
