// services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/PostModel.dart';

class ApiService {
  final String baseUrl = 'https://meowfacts.herokuapp.com';

  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/?count=10'));  

    if (response.statusCode == 200) {
      // Decode the response as a map because it's a JSON object, not a list.
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      
      // Extract the 'data' list from the map.
      List<dynamic> data = jsonResponse['data'];

      // Map the 'data' list to a list of PostModel objects.
      return data.map((fact) => PostModel.fromJson(fact)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
