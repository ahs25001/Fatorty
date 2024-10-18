import 'package:fatorty/shared/network/local/shared_preferences_manager.dart';
import 'package:flutter/material.dart';

enum RegisterStatus { initial, loading, success, fail }

class RegisterProvider extends ChangeNotifier {
  RegisterStatus registerStatus = RegisterStatus.initial;

  Future<void> saveData(
      {required String name,
      required Function onSuccess,
      required String shopName,
      required String shopAddress,
      required String phoneNumber}) async {
    try {
      registerStatus = RegisterStatus.loading;
      notifyListeners();
      await SharedPreferencesManager.saveString("name", name);
      await SharedPreferencesManager.saveString("shopName", shopName);
      await SharedPreferencesManager.saveString("shopAddress", shopAddress);
      await SharedPreferencesManager.saveString("phoneNumber", phoneNumber);
      registerStatus = RegisterStatus.success;
      onSuccess();
      notifyListeners();
    } catch (e) {
      registerStatus = RegisterStatus.fail;
      notifyListeners();
    }
  }
}
