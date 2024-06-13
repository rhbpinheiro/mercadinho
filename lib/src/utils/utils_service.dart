import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilsService {
  final storage = const FlutterSecureStorage();
  //Salvar dado localmente
  Future<void> saveLocalData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  //Recuperar dado localmente
  Future<String?> getLocalData(String key) async {
    return await storage.read(key: key);
  }

  //Remove dado localmente
  Future<void> removeLocalData(String key) async {
    await storage.delete(key: key);
  }

  void showToast({
    required bool isError,
    required String message,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: isError ? Colors.white : Colors.white,
      fontSize: 16.0,
    );
  }
}
