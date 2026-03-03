import 'package:flavor_memo_app/domain/models/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  @override
  final List<Post> posts;
  @override
  final bool isLoading;

  const HomeState({this.posts = const [], this.isLoading = false});
}
