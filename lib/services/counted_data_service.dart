import 'package:app_surat/models/counted_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountedDataService {
  final String _apiUri = dotenv.get('API_URI');
  final Dio _dio = Dio();

  Future<CountedDataPetugas> getCountedDataPetugas() async {
    try {
      String fullUri = '$_apiUri/v1/counted-data-petugas';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      final Response response = await _dio.get(fullUri,
          options: Options(headers: {"Authorization": 'Bearer $token'}));
      return CountedDataPetugas.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.copyWith(
          message: "Kesalahan pada server. Cobalah beberapa saat lagi"));
    }
  }
}
