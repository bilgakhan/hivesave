import 'package:dio/dio.dart';
import 'package:hivegenapp/model/user_model.dart';

class UserService {
  Future<dynamic> getUsers() async {
    try {
      Response response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
      } else {
        return response.statusMessage.toString();
      }
    } on DioException catch (e) {
      return e.message.toString();
    }
  }
}
