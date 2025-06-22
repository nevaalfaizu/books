import 'package:books/api/dio_client.dart';
import 'package:books/models/stat_response.dart';

class StatService {
  static Future<StatResponse> fetchStats() async {
    final response = await DioClient.dio.get('/stats');

    if (response.statusCode == 200) {
      return StatResponse.fromJson(response.data);
    } else {
      throw Exception('Gagal memuat data statistik');
    }
  }
}
