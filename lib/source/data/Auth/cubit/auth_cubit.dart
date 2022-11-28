import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:flutter_mt/source/router/string.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final MyRepository? myRepository;
  AuthCubit({required this.myRepository}) : super(AuthInitial());

  void splash(context) async {
    await Future.delayed(const Duration(seconds: 1));
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    print(email);
    if (email != null) {
      Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
    }
  }

  void login(context, email, password) async {
    emit(LoginLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    myRepository!.login(email, password).then((value) async {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print("JSON: $json");
      print("Code: $statusCode");
      emit(LoginLoaded(json: json, statusCode: statusCode));
      if (statusCode == 200) {
        pref.setString('email', json['email']);
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushNamedAndRemoveUntil(context, HOME, (route) => false);
      }
    });
  }

  void getsession(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
  }
  void keluarAkun(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('email');
    Navigator.pushNamedAndRemoveUntil(context, LOGIN, (route) => false);
  }
}
