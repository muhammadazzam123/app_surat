import 'package:app_surat/models/agenda_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgendaUndanganService {
  final String _apiUri = dotenv.get('API_URI');
  final Dio _dio = Dio();

  Future<List<AgendaUndangan>> getAgendaUndangans() async {
    try {
      final String fullUri = '$_apiUri/v1/agenda-undangans';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('appToken').toString();
      Response response = await _dio.get(fullUri,
          options: Options(headers: {"Authorization": 'Bearer $token'}));
      return (response.data as List)
          .map((e) => AgendaUndangan.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future postAgendaUndangan(Map<String, dynamic> data) async {
    try {
      final String fullUri = '$_apiUri/v1/agenda-undangans';
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

  Future patchAgendaUndangan(
      Map<String, dynamic> data, int? agendaUndanganId) async {
    try {
      final String fullUri = '$_apiUri/v1/agenda-undangans/$agendaUndanganId';
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

  Future deleteAgendaUndangan(int agendaUndanganId) async {
    try {
      final String fullUri = '$_apiUri/v1/agenda-undangans/$agendaUndanganId';
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
