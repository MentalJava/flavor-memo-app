import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_post_event.freezed.dart';

@freezed
class AddPostEvent with _$AddPostEvent {
  const factory AddPostEvent.successUploadImage() = SuccessUploadImage;
}
