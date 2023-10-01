import 'package:app_surat/models/surat_masuk_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuratMasukService {
  final String _apiUri = dotenv.get('API_URI');
  final Dio _dio = Dio();

  Future<List<SuratMasuk>> getSuratMasuks() async {
    try {
      final String fullUri = '$_apiUri/v1/surat-masuks';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      Response response = await _dio.get(fullUri,
          options: Options(headers: {"Authorization": 'Bearer $token'}));
      return (response.data as List)
          .map((e) => SuratMasuk.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future postSuratMasuk(FormData data) async {
    try {
      final String fullUri = '$_apiUri/v1/surat-masuks';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      Response response = await _dio.post(fullUri,
          data: data,
          options: Options(headers: {"Authorization": 'Bearer $token'}));
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }

  Future deleteSuratMasuk(int? suratMasukId) async {
    try {
      final String fullUri = '$_apiUri/v1/surat-masuks/$suratMasukId';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      Response response = await _dio.delete(fullUri,
          options: Options(headers: {"Authorization": 'Bearer $token'}));
      return response;
    } on DioException catch (e) {
      return e.response;
    }
  }
}
