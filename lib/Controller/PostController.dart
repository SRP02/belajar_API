// controllers/post_controller.dart

import 'package:belajar_api/utils/ApiService.dart';
import 'package:belajar_api/model/PostModel.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  var isLoading = true.obs;
  var postList = <PostModel>[].obs;

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    try {
      isLoading(true);
      var posts = await ApiService().fetchPosts();
      postList.assignAll(posts);
    } finally {
      isLoading(false);
    }
  }
}