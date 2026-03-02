import 'package:flavor_memo_app/my_app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/post.dart';
import '../widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _refreshPosts();
  }

  void _refreshPosts() {
    setState(() {
      _postsFuture = MyApp.of(context).postRepository.getPosts();
    });
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
              await MyApp.of(context).authRepository.logout();
              if (mounted && context.mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _refreshPosts(),
        child: FutureBuilder<List<Post>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('에러 발생: ${snapshot.error}'));
            }
            final posts = snapshot.data ?? [];
            if (posts.isEmpty) {
              return const Center(child: Text('게시물이 없습니다.'));
            }
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) => PostWidget(post: posts[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/add'),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
