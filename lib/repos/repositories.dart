import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:user/model/userDetails.dart';

class UserRepository {
  var client = http.Client();

  Future<List<UserDetails>> getDetails(String index) async {
    String api = "https://jsonplaceholder.typicode.com/users";
    var url = Uri.parse(api);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final List result = convert.jsonDecode(response.body);
      return result.map(((e) => UserDetails.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<UserDetails> getDetailsById(String index) async {
    String api = "https://jsonplaceholder.typicode.com/users/${index}";
    var url = Uri.parse(api);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = convert.jsonDecode(response.body);
      return UserDetails.fromJson(result);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
