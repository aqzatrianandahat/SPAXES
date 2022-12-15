import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../Model/space.dart';
import '../Model/user.dart';

class SpaxesService {
  final String baseUrlApi = "http://10.10.100.21:3000";

  Future<List<Space>> fetchUser() async {
    Response response = await Dio().get("$baseUrlApi/detail");
    List<Space> space =
        (response.data as List).map((v) => Space.fromJSON(v)).toList();
    return space;
  }

  Future<User> fetchDataUser(int idUser) async {
    Response response = await Dio().get("$baseUrlApi/users/$idUser");
    User users = User.fromJSON(response.data);
    return users;
  }
}
