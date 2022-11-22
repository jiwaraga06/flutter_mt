import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'perbaikan_state.dart';

class PerbaikanCubit extends Cubit<PerbaikanState> {
  final MyRepository? myRepository;
  PerbaikanCubit({required this.myRepository}) : super(PerbaikanInitial());

  void getPerbaikan() async {
    emit(PerbaikanLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    myRepository!.getTaskPerbaikanPerawatan(email).then((value) {
      var json = jsonDecode(value.body);
      print("TaskList: $json");
      if (value.statusCode == 200) {
        emit(PerbaikanLoaded(json: json['perbaikan']));
      }
    });
  }
}
