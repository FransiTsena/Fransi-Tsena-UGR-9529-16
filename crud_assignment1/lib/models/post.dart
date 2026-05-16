class Reactions {
  final int likes;
  final int dislikes;

  Reactions({required this.likes, required this.dislikes});

  factory Reactions.fromJson(Map<String, dynamic> json) {
    return Reactions(
      likes: json['likes'] ?? 0,
      dislikes: json['dislikes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      'dislikes': dislikes,
    };
  }
}

class Post {
  final int? id;
  final String title;
  final String body;
  final List<String> tags;
  final Reactions reactions;
  final int views;
  final int userId;

  Post({
    this.id,
    required this.title,
    required this.body,
    required this.tags,
    required this.reactions,
    required this.views,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      reactions: Reactions.fromJson(json['reactions'] ?? {'likes': 0, 'dislikes': 0}),
      views: json['views'] ?? 0,
      userId: json['userId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'body': body,
      'tags': tags,
      'reactions': reactions.toJson(),
      'views': views,
      'userId': userId,
    };
  }

  Post copyWith({
    int? id,
    String? title,
    String? body,
    List<String>? tags,
    Reactions? reactions,
    int? views,
    int? userId,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      tags: tags ?? this.tags,
      reactions: reactions ?? this.reactions,
      views: views ?? this.views,
      userId: userId ?? this.userId,
    );
  }
}
