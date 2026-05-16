import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/post_provider.dart';
import 'post_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        Provider.of<PostProvider>(context, listen: false).fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                Provider.of<PostProvider>(context, listen: false).fetchPosts(),
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          if (provider.posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          return ListView.builder(
            itemCount: provider.posts.length,
            itemBuilder: (context, index) {
              final post = provider.posts[index];
              return ListTile(
                title: Text(post.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.body,
                        maxLines: 3, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    if (post.tags.isNotEmpty)
                      Wrap(
                        spacing: 4,
                        children: post.tags
                            .map((tag) => Chip(
                                  label: Text(tag,
                                      style: const TextStyle(fontSize: 10)),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ))
                            .toList(),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.thumb_up_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text('${post.reactions.likes}'),
                        const SizedBox(width: 12),
                        const Icon(Icons.thumb_down_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text('${post.reactions.dislikes}'),
                        const SizedBox(width: 12),
                        const Icon(Icons.visibility_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text('${post.views}'),
                      ],
                    ),
                  ],
                ),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostFormScreen(post: post),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    provider.deletePost(post.id!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostFormScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
