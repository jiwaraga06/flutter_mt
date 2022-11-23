import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'ket_mesin_state.dart';

class KetMesinCubit extends Cubit<KetMesinState> {
  final MyRepository? myRepository;
  KetMesinCubit({required this.myRepository}) : super(KetMesinInitial());
  void getMesin(id_mesin) async {
    emit(KetMesinLoading());
    myRepository!.getKetMesin(id_mesin).then((value) {
      var json = jsonDecode(value.body);
      print("KET MESIN: $json");
      print("KET MESIN Status: ${value.statusCode}");
      emit(KetMesinLoaded(json: json, statusCode: value.statusCode));
    });
  }
}
