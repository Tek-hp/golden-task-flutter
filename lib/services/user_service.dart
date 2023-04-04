import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskapp/enum/user_keys.dart';
import 'package:taskapp/models/user_model.dart';

class UserService {
  final Box<UserModel> _usersLogBox =
      Hive.box<UserModel>(UserKeys.loggedIn.name);
  final Box<UserModel> _allUsersBox =
      Hive.box<UserModel>(UserKeys.allUsers.name);

  Future<bool> isLoggedIn() async {
    if (_usersLogBox.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<String> logIn(
      {required String email, required String password}) async {
    try {
      if (_allUsersBox.containsKey(email)) {
        UserModel userFromDataBase = _allUsersBox.get(email)!;

        if (userFromDataBase.password != password) {
          return "Password did not match";
        }
        if (_usersLogBox.isNotEmpty) {
          await _usersLogBox.clear();
        }

        await _usersLogBox.put(userFromDataBase.email, userFromDataBase);
        return "Logged in";
      } else {
        return "E-mail is not registered.";
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> logout() async {
    try {
      if (_usersLogBox.isNotEmpty) {
        await _usersLogBox.clear();

        return "Logged out";
      } else {
        return "No Session Found";
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> register({required UserModel user}) async {
    try {
      if (!_allUsersBox.containsKey(user.email)) {
        await _allUsersBox.put(user.email, user);
        await logIn(email: user.email, password: user.password);
        return "Successfully Registered";
      } else {
        return "Email already in use";
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<bool> userExists({required UserModel userToCheck}) async {
    return _allUsersBox.containsKey(userToCheck.email);
  }
}
