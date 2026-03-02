class Post {
  final String id;
  final String userId;
  final String imagePath;
  final String caption;
  final DateTime createdAt;

  const Post({
    required this.id,
    required this.userId,
    required this.imagePath,
    required this.caption,
    required this.createdAt,
  });
}
