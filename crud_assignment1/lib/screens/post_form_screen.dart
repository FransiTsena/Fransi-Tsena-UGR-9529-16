import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../providers/post_provider.dart';

class PostFormScreen extends StatefulWidget {
  final Post? post;

  const PostFormScreen({super.key, this.post});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late TextEditingController _tagsController;
  late TextEditingController _userIdController;
  late TextEditingController _viewsController;
  late TextEditingController _likesController;
  late TextEditingController _dislikesController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _bodyController = TextEditingController(text: widget.post?.body ?? '');
    _tagsController = TextEditingController(text: widget.post?.tags.join(', ') ?? '');
    _userIdController = TextEditingController(text: widget.post?.userId.toString() ?? '5');
    _viewsController = TextEditingController(text: widget.post?.views.toString() ?? '0');
    _likesController = TextEditingController(text: widget.post?.reactions.likes.toString() ?? '0');
    _dislikesController = TextEditingController(text: widget.post?.reactions.dislikes.toString() ?? '0');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _tagsController.dispose();
    _userIdController.dispose();
    _viewsController.dispose();
    _likesController.dispose();
    _dislikesController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<PostProvider>(context, listen: false);
      
      final List<String> tags = _tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final post = Post(
        id: widget.post?.id,
        title: _titleController.text,
        body: _bodyController.text,
        tags: tags,
        reactions: Reactions(
          likes: int.tryParse(_likesController.text) ?? 0,
          dislikes: int.tryParse(_dislikesController.text) ?? 0,
        ),
        views: int.tryParse(_viewsController.text) ?? 0,
        userId: int.tryParse(_userIdController.text) ?? 5,
      );

      if (widget.post == null) {
        await provider.addPost(post);
      } else {
        await provider.updatePost(post);
      }

      if (mounted) {
        if (provider.error == null) {
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${provider.error}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Create Post' : 'Edit Post'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Body'),
                maxLines: 5,
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter a body' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(labelText: 'Tags (comma separated)'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _userIdController,
                      decoration: const InputDecoration(labelText: 'User ID'),
                      keyboardType: TextInputType.number,
                      validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _viewsController,
                      decoration: const InputDecoration(labelText: 'Views'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _likesController,
                      decoration: const InputDecoration(labelText: 'Likes'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _dislikesController,
                      decoration: const InputDecoration(labelText: 'Dislikes'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Consumer<PostProvider>(
                builder: (context, provider, child) {
                  return provider.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: Text(widget.post == null ? 'Create' : 'Update'),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
