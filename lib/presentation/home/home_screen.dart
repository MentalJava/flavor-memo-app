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
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async => onAction(const HomeAction.loadPosts()),
              child: ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) =>
                    PostWidget(post: state.posts[index]),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onAction(const HomeAction.addPost()),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
