import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../Model/detail.dart';
import '../Model/user.dart';

class SpaxesService {
  final String baseUrlApi = "http://10.10.100.21:3000";

  Future<List<Detail>> fetchUser() async {
    Response response = await Dio().get("$baseUrlApi/detail");
    List<Detail> detail =
        (response.data as List).map((v) => Detail.fromJSON(v)).toList();
    return detail;
  }

  Future<User> fetchDataUser(int idUser) async {
    Response response = await Dio().get("$baseUrlApi/users/$idUser");
    User users = User.fromJSON(response.data);
    return users;
  }

  Future<Detail> fetchDataSpace(int idSpace) async {
    Response response = await Dio().get("$baseUrlApi/detail/$idSpace");
    Detail detail = Detail.fromJSON(response.data);
    return detail;
  }
}
