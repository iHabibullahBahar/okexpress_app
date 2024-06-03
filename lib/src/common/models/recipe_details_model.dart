class RecipeDetailsModel {
  bool? success;
  String? message;
  Data? data;

  RecipeDetailsModel({this.success, this.message, this.data});

  RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    try {
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      try {
        data['data'] = this.data!.toJson();
      } catch (e) {
        print(e);
      }
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? slug;
  String? image;
  String? video;
  double? calory;
  double? protein;
  double? carb;
  double? fat;
  List<String>? mealOption;
  List<Ingredient>? ingredient;
  bool? isFavorite;
  String? description;
  String? cookMethod;
  String? createdAt;

  Data(
      {this.id,
      this.name,
      this.slug,
      this.image,
      this.video,
      this.calory,
      this.protein,
      this.carb,
      this.fat,
      this.mealOption,
      this.ingredient,
      this.isFavorite,
      this.description,
      this.cookMethod,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    video = json['video'];
    calory = json['calory']?.toDouble();
    protein = json['protein']?.toDouble();
    carb = json['carb'];
    fat = json['fat'];
    mealOption = json['meal_option'].cast<String>();
    if (json['ingredient'] != null) {
      ingredient = <Ingredient>[];
      try {
        json['ingredient'].forEach((v) {
          ingredient!.add(new Ingredient.fromJson(v));
        });
      } catch (e) {
        print(e);
      }
    }
    isFavorite = json['is_favorite'];
    description = json['description'];
    cookMethod = json['cook_method'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['video'] = this.video;
    data['calory'] = this.calory;
    data['protein'] = this.protein;
    data['carb'] = this.carb;
    data['fat'] = this.fat;
    data['meal_option'] = this.mealOption;
    if (this.ingredient != null) {
      try {
        data['ingredient'] = this.ingredient!.map((v) => v.toJson()).toList();
      } catch (e) {
        print(e);
      }
    }
    data['is_favorite'] = this.isFavorite;
    data['description'] = this.description;
    data['cook_method'] = this.cookMethod;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Ingredient {
  int? ingredientId;
  int? rootIngredientId;
  String? ingredientName;
  int? amount;
  String? unit;

  Ingredient(
      {this.ingredientId,
      this.rootIngredientId,
      this.ingredientName,
      this.amount,
      this.unit});

  Ingredient.fromJson(Map<String, dynamic> json) {
    ingredientId = json['ingredient_id'];
    rootIngredientId = json['root_ingredient_id'];
    ingredientName = json['ingredient_name'];
    amount = json['amount']?.toInt();
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ingredient_id'] = this.ingredientId;
    data['root_ingredient_id'] = this.rootIngredientId;
    data['ingredient_name'] = this.ingredientName;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    return data;
  }
}
