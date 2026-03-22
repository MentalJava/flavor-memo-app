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
    print('DEBUG: [FirestorePostRepository] getPosts() 시작');
    try {
      final snapshot = await _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .get();

      print(
        'DEBUG: [FirestorePostRepository] 조회된 문서 수: ${snapshot.docs.length}',
      );

      final posts = snapshot.docs.map((doc) {
        print(
          'DEBUG: [FirestorePostRepository] 문서 데이터: ID=${doc.id}, DATA=${doc.data()}',
        );
        return PostDto.fromFirestore(doc).toModel();
      }).toList();

      return posts;
    } catch (e, stackTrace) {
      print('DEBUG: [FirestorePostRepository] 에러 발생: $e');
      print('DEBUG: [FirestorePostRepository] 스택 트레이스: $stackTrace');
      rethrow;
    }
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
