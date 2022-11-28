import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final MyRepository? myRepository;
  ProfileCubit({required this.myRepository}) : super(ProfileInitial());
  
  void getProfile() async {
    emit(ProfileLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    myRepository!.getProfile(email).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('JSON PROFILE: $json');
      emit(ProfileLoaded(json: json, statusCode: statusCode));
    });
  }
}
