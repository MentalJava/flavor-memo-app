import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_post_state.freezed.dart';

@freezed
class AddPostState with _$AddPostState {
  @override
  final String? imagePath;
  @override
  final bool isUploading;

  const AddPostState({this.imagePath, this.isUploading = false});
}
