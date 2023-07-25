
import 'package:dio/dio.dart';

const String apiKey = 'iglwkphLx86XaHd2So3rDys8PwFB3QyzApfhx1qE-DQ';

class UnsplashApiService {
  final Dio _dio = Dio();

  Future<List<String>> getRandomImages(int count, category ) async {
    try {
      final response = await _dio.get(
        'https://api.unsplash.com/photos/random',
        queryParameters: {
          'client_id': apiKey,
          'count': count,
          'guery': category,
        },
      );

      final data = response.data as List<dynamic>;
      final imageUrls = data.map((item) => item['urls']['regular'] as String).toList();
      return imageUrls;
    } catch (error) {
      throw Exception('Failed to fetch random images: $error');
    }
  }
  Future<List<String>> getCategoryNames() async {
  try {
    final response = await _dio.get(
        'https://api.unsplash.com/collections',
      queryParameters: {
        'client_id': apiKey,
      },
    );

    final data = response.data as List<dynamic>;
    final categoryNames = data.map((item) => item['title'] as String).toList();
    return categoryNames;
  } catch (error) {
    throw Exception('Failed to fetch category names: $error');
  }
}
Future<List<String>> searchImages(String query, int count) async {
  try {
    final response = await _dio.get(
      'https://api.unsplash.com/search/photos',
      queryParameters: {
        'client_id': apiKey,
        'query': query,
        'per_page': count,
      },
    );

    final data = response.data['results'] as List<dynamic>;
    final imageUrls = data.map((item) => item['urls']['regular'] as String).toList();
    return imageUrls;
  } catch (error) {
    throw Exception('Failed to search images: $error');
  }
}
}
