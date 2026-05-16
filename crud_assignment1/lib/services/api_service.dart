import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> postsJson = data['posts'];
      return postsJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<Post> updatePost(Post post) async {
    if (post.id == null) throw Exception('Post ID is required for update');

    final response = await http.put(
      Uri.parse('$_baseUrl/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
