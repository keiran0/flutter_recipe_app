import "package:dio/dio.dart";
import "package:recipes_app/const.dart";
class HTTPService {

  static final HTTPService _singleton = HTTPService._internal();

  final _dio = Dio();

  factory HTTPService() {
    return _singleton; 
    //singleton is a design pattern that ensures that a class has only one instance 
    //and provides a global point of access to that instance.
    //the factory constructor provides access to the single instance of the class.
  }

  HTTPService._internal() {
    setup();
  }

  Future<void> setup({String? bearerToken}) async {

    final headers = {
      "Content-Type": "application/json",
    };

    if (bearerToken!= null) {
      headers['Authorization'] = "Bearer : $bearerToken";
    }

    final options = BaseOptions( //tell dio to use these options with every request it sends.
      baseUrl: API_BASE_URL,
      headers: headers,
      validateStatus: (status) {
        if (status == null){
          return false;
        } 
        return status < 500;
      }
    );

    _dio.options = options;

  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = await _dio.post(path, data:data);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<Response?> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
  }

}