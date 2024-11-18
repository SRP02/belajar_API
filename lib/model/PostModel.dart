// models/post_model.dart

class PostModel {
  final String fact;

  PostModel({required this.fact});

  // Factory method to create an instance of PostModel from JSON
  factory PostModel.fromJson(String json) {
    return PostModel(
      fact: json, // The fact is just a string
    );
  }
}
