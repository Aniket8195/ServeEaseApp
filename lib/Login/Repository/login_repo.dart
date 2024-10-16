import 'package:serve_ease/API/api_url.dart';
import 'package:serve_ease/API/dio_instance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepo{
  static const String _roleKey = 'role';
  static const String _idKey = 'id';
  static const String _tokenKey = 'token';

  MainInstance mainInstance = MainInstance();

  // Save user data (role, id, token) in SharedPreferences
  Future<void> saveUserData(String role, int id, String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, role);
    await prefs.setInt(_idKey, id);
    await prefs.setString(_tokenKey, token);
  }

  Future<void>loginSeeker(String email, String password) async{
    try{

      final response = await mainInstance.dio.post(seekerLogin, data: {
        'email': email,
        'password': password,
      });
      if(response.statusCode == 200){
        await saveUserData('SEEKER', response.data['id'], response.data['token']);
      }
      else {
        throw Exception('Failed to login');
      }
    }
    catch(e){
      rethrow ;
    }
  }

  Future<void>loginProvider(String email, String password) {
    try {
      return mainInstance.dio.post(providerLogin, data: {
        'email': email,
        'password': password,
      }).then((response) async {
        if (response.statusCode == 200) {
          await saveUserData('PROVIDER', response.data['id'], response.data['token']);
        } else {
          throw Exception('Failed to login');
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}