import 'package:dio/dio.dart';
import 'dart:io';

class TumorDetectionModel {
  final Dio _dio = Dio();
  final String apiUrl = "http://10.0.2.2:8000/predict";

  Future<String> diagnose(File image) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: 'mri_scan.jpg',
        ),
      });

      Response response = await _dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200) {
        final result = response.data['predicted_class'];
        if (result != null) {
          return result;
        } else {
          throw Exception('No result found in response');
        }
      } else {
        throw Exception('Failed to load diagnosis: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Dio Error: ${e.message}');
      print('Response: ${e.response?.data}');
      throw Exception('Failed to load diagnosis: ${e.message}');
    }
  }
}
