import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskapp/app.dart';
import 'package:taskapp/enum/user_keys.dart';
import 'package:taskapp/models/user_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());

  await Hive.openBox<UserModel>(UserKeys.loggedIn.name);
  await Hive.openBox<UserModel>(UserKeys.allUsers.name);

  runApp(ProviderScope(child: RemoteCoach()));
}
