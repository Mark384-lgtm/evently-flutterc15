import 'package:evently_c15_flutter/core/remote/network/FireStoreManger.dart';
import 'package:flutter/material.dart';

import 'model/User.dart';

class UserProvidedr extends ChangeNotifier {
  User? currentUser;

   fetchUser(String uid)async {
    currentUser=await FireStoreManger.getUSer(uid);
    notifyListeners();
  }
}