import 'package:flavor_memo_app/domain/model/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  @override
  final List<Post> posts;
  @override
  final bool isLoading;
  @override
  final String? errorMessage;

  HomeState({this.posts = const [], this.isLoading = false, this.errorMessage});
}
