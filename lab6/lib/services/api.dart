import 'dart:convert';
import 'package:lab6/models/photo.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/photos';

  static Future<Photo> getPhoto(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Photo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load the photo');
    }
  }
}
