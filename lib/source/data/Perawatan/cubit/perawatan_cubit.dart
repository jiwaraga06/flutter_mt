import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'perawatan_state.dart';

class PerawatanCubit extends Cubit<PerawatanState> {
  final MyRepository? myRepository;
  PerawatanCubit({required this.myRepository}) : super(PerawatanInitial());
  void getPerawatan() async {
    emit(PerawatanLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    myRepository!.getTaskPerbaikanPerawatan(email).then((value) {
      var json = jsonDecode(value.body);
      print("TaskList: $json");
      print("TaskList Code: ${value.statusCode}");
      emit(PerawatanLoaded(json: json, statusCode: value.statusCode));
    });
  }
}
