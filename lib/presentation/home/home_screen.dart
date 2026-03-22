import 'package:flavor_memo_app/presentation/home/home_action.dart';
import 'package:flavor_memo_app/presentation/home/home_state.dart';
import 'package:flutter/material.dart';
import '../component/post_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeState state;
  final Function(HomeAction) onAction;

  const HomeScreen({super.key, required this.state, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flavor Memo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => onAction(const HomeAction.logOut()),
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAction(const HomeAction.addPost()),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget _buildBody() {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              '오류가 발생했습니다:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(state.errorMessage!),
            ),
            ElevatedButton(
              onPressed: () => onAction(const HomeAction.loadPosts()),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    if (state.posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.post_add, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('게시물이 없습니다.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => onAction(const HomeAction.loadPosts()),
              child: const Text('새로고침'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => onAction(const HomeAction.loadPosts()),
      child: ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (context, index) => PostWidget(post: state.posts[index]),
      ),
    );
  }
}
