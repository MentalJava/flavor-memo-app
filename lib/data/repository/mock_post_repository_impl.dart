import '../../domain/models/post.dart';
import '../../domain/repositories/post_repository.dart';

class MockPostRepositoryImpl implements PostRepository {
  final List<Post> _posts = [
    Post(
      id: '1',
      userId: '1',
      imagePath: 'https://picsum.photos/id/10/400/400',
      caption: '아름다운 풍경입니다.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Post(
      id: '2',
      userId: '1',
      imagePath: 'https://picsum.photos/id/20/400/400',
      caption: '오늘의 점심!',
      createdAt: DateTime.now().subtract(const Duration(hours: 4)),
    ),
  ];

  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_posts.reversed);
  }

  @override
  Future<void> addPost(Post post) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _posts.add(post);
  }
}
