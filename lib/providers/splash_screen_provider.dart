import 'package:flutter/material.dart';

import '../shared/network/local/shared_preferences_manager.dart';

class SplashScreenProvider extends ChangeNotifier {
  String? name;
  Future<void> getData() async {
    try{
      name = await SharedPreferencesManager.getString("name");
      notifyListeners();
    }catch(e){
      notifyListeners();
    }

  }
}
