class IngredientModel {
  bool? success;
  String? message;
  Data? data;

  IngredientModel({this.success, this.message, this.data});

  IngredientModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Ingredient>? ingredient;

  Data({this.ingredient});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['ingredient'] != null) {
      ingredient = <Ingredient>[];
      json['ingredient'].forEach((v) {
        ingredient!.add(new Ingredient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ingredient != null) {
      data['ingredient'] = this.ingredient!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredient {
  int? ingredientId;
  int? rootIngredientId;
  String? ingredientName;
  double? amount;
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
    amount = json['amount']?.toDouble();
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
