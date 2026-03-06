import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_post_action.freezed.dart';

@freezed
sealed class AddPostAction with _$AddPostAction {
  const factory AddPostAction.onPickImage() = OnPickImage;
  const factory AddPostAction.onUpload(String content) = OnUpload;
}
