import 'package:serve_ease/Models/category_model.dart';

import '../../API/api_url.dart';
import '../../API/dio_instance.dart';

class RegisterRepo{


  Future<List<CategoryModel>>getCategories() async{
    final response= await MainInstance().dio.get(categoriesURL);

    if (response.statusCode == 200) {
      List<CategoryModel> categories = [];

      var data = response.data['data'];

      for (var category in data) {
        categories.add(CategoryModel.fromJson(category));
      }

      return categories;
    }
    else{
      throw Exception('Failed to load categories');
    }

  }

  Future<void>registerProvider(String email, String name, String password, List<int> categories)async {
    try
    {
      final response = await MainInstance().dio.post(providerRegistration, data: {
        'email': email,
        'name': name,
        'password': password,
        'categoryIds': categories
      });

      if (response.statusCode == 201) {
        return;
      }
      else{
        throw Exception('Failed to register');
      }
    }
    catch(e){
      throw Exception('Failed to register');
    }
  }

  Future<void>registerSeeker(String email, String name, String password)async {
    try
    {
      final response = await MainInstance().dio.post(seekerRegistration, data: {
        'email': email,
        'name': name,
        'password': password,
      });

      if (response.statusCode == 201) {
        return;
      }
      else{
        throw Exception('Failed to register');
      }
    }
    catch(e){
      throw Exception('Failed to register');
    }
  }

}