import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/model/post.dart';
import '../../domain/repository/post_repository.dart';
import '../dto/post_dto.dart';
import '../mapper/post_mapper.dart';

class FirestorePostRepositoryImpl implements PostRepository {
  final FirebaseFirestore _firestore;

  FirestorePostRepositoryImpl(this._firestore);

  @override
  Future<List<Post>> getPosts() async {
    final snapshot = await _firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => PostDto.fromFirestore(doc).toModel())
        .toList();
  }

  @override
  Future<void> addPost(Post post) async {
    final dto = post.toDto();
    await _firestore
        .collection('posts')
        .doc(post.id.isEmpty ? null : post.id)
        .set(dto.toJson());
  }
}
