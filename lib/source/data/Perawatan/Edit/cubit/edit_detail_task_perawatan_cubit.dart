import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_detail_task_perawatan_state.dart';

class EditDetailTaskPerawatanCubit extends Cubit<EditDetailTaskPerawatanState> {
  final MyRepository? myRepository;
  EditDetailTaskPerawatanCubit({required this.myRepository}) : super(EditDetailTaskPerawatanInitial());

  void getDetailTaskPerawatan() async {
    emit(EditDetailTaskPerawatanLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var kode_penugasan = pref.getString('kode_penugasan');
    print(kode_penugasan);

    myRepository!.getDetailTaskPerawatan(kode_penugasan).then((value) {
      var json = jsonDecode(value.body);
      print("JSON: $json");
      print("JSON Code: ${value.statusCode}");
      emit(EditDetailTaskPerawatanLoaded(json: json, statusCode: value.statusCode));
    });
  }
}
