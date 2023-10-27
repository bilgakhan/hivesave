import 'package:flutter/material.dart';
import 'package:hivegenapp/db/db_service.dart';
import 'package:hivegenapp/model/user_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data from DB"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: UserDbService().checkBox(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.data is String) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              List<UserModel> data = snapshot.data as List<UserModel>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].name.toString()),
                    subtitle: Text(data[index].email.toString()),
                  );
                },
                itemCount: data.length,
              );
            }
          }),
    );
  }
}
