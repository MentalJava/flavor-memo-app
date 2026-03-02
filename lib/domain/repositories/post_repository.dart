import '../models/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<void> addPost(Post post);
}
