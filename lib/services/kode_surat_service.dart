import 'package:app_surat/models/kode_surat_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KodeSuratService {
  final String _apiUri = dotenv.get('API_URI');
  final Dio _dio = Dio();

  Future<List<KodeSurat>> getfilteredKodeSurats() async {
    try {
      final String fullUri = '$_apiUri/v1/filtered-kode-surats';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      Response response = await _dio.get(fullUri,
          options: Options(headers: {"Authorization": 'Bearer $token'}));
      return (response.data as List).map((e) => KodeSurat.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
