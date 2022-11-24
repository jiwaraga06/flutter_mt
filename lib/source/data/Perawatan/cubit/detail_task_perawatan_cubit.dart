import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_task_perawatan_state.dart';

class DetailTaskPerawatanCubit extends Cubit<DetailTaskPerawatanState> {
  final MyRepository? myRepository;
  DetailTaskPerawatanCubit({required this.myRepository}) : super(DetailTaskPerawatanInitial());
  
  void getDetailTaskPerawatan()async {
    emit(DetailTaskPerawatanLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var kode_penugasan = pref.getString('kode_penugasan');
    print(kode_penugasan);
    myRepository!.getDetailTaskPerawatan(kode_penugasan).then((value){
      var json = jsonDecode(value.body);
      print("JSON: $json");
      print("JSON Code: ${value.statusCode}");
      emit(DetailTaskPerawatanLoaded(json: json, statusCode: value.statusCode));
    });
  }
}
