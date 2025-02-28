import 'package:recipes_app/services/http_service.dart';
import '../models/user.dart';


class AuthService {

  static final AuthService _singleton = AuthService._internal();

  User? user; //saving the user in the authservice

  final _httpService = HTTPService();

  factory AuthService() {
    return _singleton; 
    //singleton is a design pattern that ensures that a class has only one instance 
    //and provides a global point of access to that instance.
    //the factory constructor provides access to the single instance of the class.
  }

  AuthService._internal();

//the below function will take some time to complete. once it completes, it will return a bool value to us. 
  Future<bool> login(String username, String password) async {
    try {
      var response = await _httpService.post('auth/login', {"username": username, "password": password});
      print(response?.statusCode);
      if (response?.statusCode == 200 && response?.data != null) {
        //print(response!.data);
        user = User.fromJson(response!.data);
        //print(user);
        HTTPService().setup(bearerToken: user!.accessToken);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

}