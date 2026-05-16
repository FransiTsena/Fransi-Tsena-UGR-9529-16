import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/api_service.dart';

class PostProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosts() async {
    _setLoading(true);
    try {
      _posts = await _apiService.fetchPosts();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addPost(Post post) async {
    _setLoading(true);
    try {
      final newPost = await _apiService.createPost(post);
      _posts.insert(0, newPost);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updatePost(Post post) async {
    _setLoading(true);
    try {
      final updatedPost = await _apiService.updatePost(post);
      final index = _posts.indexWhere((p) => p.id == updatedPost.id);
      if (index != -1) {
        _posts[index] = updatedPost;
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deletePost(int id) async {
    _setLoading(true);
    try {
      await _apiService.deletePost(id);
      _posts.removeWhere((p) => p.id == id);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
