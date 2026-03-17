import '../../domain/model/post.dart';
import '../dto/post_dto.dart';

extension PostMapper on Post {
  PostDto toDto() {
    return PostDto(
      id: id,
      userId: userId,
      imagePath: imagePath,
      caption: caption,
      createdAt: createdAt,
    );
  }
}

extension PostDtoMapper on PostDto {
  Post toModel() {
    return Post(
      id: id,
      userId: userId,
      imagePath: imagePath,
      caption: caption,
      createdAt: createdAt,
    );
  }
}
