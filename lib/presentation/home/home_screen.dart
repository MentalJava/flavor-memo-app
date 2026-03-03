import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/repository/auth_repository.dart';
import '../component/post_widget.dart';
import 'home_view_model.dart';

class HomeScreen extends StatefulWidget {
  final HomeViewModel viewModel;
  final AuthRepository authRepository;

  const HomeScreen({
    super.key,
    required this.viewModel,
    required this.authRepository,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flavor Memo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await widget.authRepository.logout();
              if (mounted && context.mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          if (widget.viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (widget.viewModel.errorMessage != null) {
            return Center(
              child: Text('에러 발생: ${widget.viewModel.errorMessage}'),
            );
          }
          final posts = widget.viewModel.posts;
          if (posts.isEmpty) {
            return const Center(child: Text('게시물이 없습니다.'));
          }
          return RefreshIndicator(
            onRefresh: () async => widget.viewModel.fetchPosts(),
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => PostWidget(post: posts[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
