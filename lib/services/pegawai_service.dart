import 'package:app_surat/models/pegawai_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PegawaiService {
  final String _apiUri = dotenv.get('API_URI');
  final Dio _dio = Dio();

  Future<List<Pegawai>> getPegawais() async {
    try {
      final String fullUri = '$_apiUri/v1/pegawais';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      Response response = await _dio.get(fullUri,
          options: Options(headers: {"Authorization": 'Bearer $token'}));
      return (response.data as List).map((e) => Pegawai.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
