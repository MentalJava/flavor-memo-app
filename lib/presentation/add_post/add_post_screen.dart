import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import '../../domain/models/post.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/post_repository.dart';

class AddPostScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final PostRepository postRepository;

  const AddPostScreen({
    super.key,
    required this.authRepository,
    required this.postRepository,
  });

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _captionController = TextEditingController();
  File? _image;
  final _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _handleShare() async {
    if (_image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('사진을 선택해주세요.')));
      return;
    }

    setState(() => _isUploading = true);
    try {
      final user = widget.authRepository.currentUser;
      final newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user?.id ?? 'anonymous',
        imagePath: _image!.path,
        caption: _captionController.text,
        createdAt: DateTime.now(),
      );

      await widget.postRepository.addPost(newPost);
      if (mounted) context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('게시 중 에러 발생: $e')));
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.go('/'),
        ),
        actions: [
          TextButton(
            onPressed: _isUploading ? null : _handleShare,
            child: const Text(
              '공유',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_isUploading) const LinearProgressIndicator(),
            GestureDetector(
              onTap: _pickImage,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: Colors.grey[200],
                  child: _image == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text('클릭하여 사진 선택'),
                          ],
                        )
                      : Image.file(_image!, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _captionController,
                decoration: const InputDecoration(
                  hintText: '문구 입력...',
                  border: InputBorder.none,
                ),
                maxLines: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
