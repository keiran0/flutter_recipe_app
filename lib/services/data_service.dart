

import "../models/recipe.dart";
import "../services/http_service.dart";

class DataService {
  static final DataService _singleton = DataService._internal();

  final HTTPService _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  //question mark because you might fail when fetching the data. 
  Future<List<Recipe>?> getRecipes(String filter) async {
    String path = "recipes/";
    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      //print(response!.data);
      List data = response!.data['recipes'];
      List<Recipe> recipes = data.map((e)=> Recipe.fromJson(e)).toList();
      print(recipes);
      return recipes;
    }
  }

}