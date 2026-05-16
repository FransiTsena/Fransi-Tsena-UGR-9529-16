class Photo {
  final int? albumId;
  final int? id;
  final String title;
  final String? url;
  final String? tubmnailUrl;

  Photo({
    this.albumId,
    this.id,
    this.url,
    this.tubmnailUrl,
    required this.title,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      url: json['url'],
      tubmnailUrl: json['thumbnailUrl'],
      title: json['title'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'id': id,
      'url': url,
      'thumbnailUrl': tubmnailUrl,
      'title': title,
    };
  }
}
