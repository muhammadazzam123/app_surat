import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _apiUri = dotenv.get('API_URI');
  final Dio _dio = Dio();

  authLogin(Map<String, dynamic> data) async {
    try {
      String fullUri = '$_apiUri/v1/auth/login';
      final response = await _dio.post(fullUri, data: data);
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }

  authLogout() async {
    try {
      String fullUri = '$_apiUri/v1/auth/logout';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      final response = await _dio.post(fullUri,
          options: Options(headers: {
            Headers.contentTypeHeader: 'application/json',
            Headers.acceptHeader: 'application/json',
            "Authorization": 'Bearer $token'
          }));
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}
