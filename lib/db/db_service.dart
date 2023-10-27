import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivegenapp/model/user_model.dart';
import 'package:hivegenapp/service/user_service.dart';
import 'package:path_provider/path_provider.dart';

class UserDbService {
  Box<UserModel>? box;
  final UserService _service = UserService();
  Future<void> openBox() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    box = await Hive.openBox<UserModel>("db");
    print("Box opened");
  }

  Future<void> writeToDb(List<UserModel> model) async {
    await box!.addAll(model);
  }

  Future<dynamic> getUserData() async {
    dynamic response = await _service.getUsers();
    if (response is List<UserModel>) {
      await openBox();
      await writeToDb(response);
      return box!.values.toList();
    } else {
      return response;
    }
  }

  Future<dynamic> checkBox() async {
    await openBox();
    if (box!.isNotEmpty) {
      print("Box checked");
      return box!.values.toList();
    } else {
      return getUserData();
    }
  }

  static void registerAdapter() {
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(AddressAdapter());
    Hive.registerAdapter(GeoAdapter());
    Hive.registerAdapter(CompanyAdapter());
  }
}
