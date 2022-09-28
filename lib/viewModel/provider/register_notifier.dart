import 'package:flutter/material.dart';
import 'package:neo_registration_page/models/register_info.dart';
import 'package:neo_registration_page/utils/enum/education.dart';
import 'package:neo_registration_page/utils/enum/state.dart';

class RegisterNotifier extends ChangeNotifier{
  RegisterInfo? _registerInfo;
  RegisterInfo? get registerInfo => _registerInfo;
  set registerInfo(RegisterInfo? registerInfo) {
    _registerInfo = registerInfo;
    notifyListeners();
  }

  Education? _education;
  Education? get education => _education;
  set education(Education? education) {
    _education = education;
    notifyListeners();
  }

  States? _state;
  States? get states => _state;
  set state(States? state) {
    _state = state;
    notifyListeners();
  }

  bool canNavigate() {
    return false;
  }

  void resetAllData() {
    _registerInfo = null;
    notifyListeners();
  }
}