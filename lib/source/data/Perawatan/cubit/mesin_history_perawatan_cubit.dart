import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'mesin_history_perawatan_state.dart';

class MesinHistoryPerawatanCubit extends Cubit<MesinHistoryPerawatanState> {
  final MyRepository? myRepository;
  MesinHistoryPerawatanCubit({required this.myRepository}) : super(MesinHistoryPerawatanInitial());

  void mesinHistoryPerawatan(id_mesin) async {
    emit(MesinHistoryPerawatanLoading());
    myRepository!.mesin_history_perawatan(id_mesin, 1, 5).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('JSON MESIN HISTORY PERAWATAN: \n $json');
      emit(MesinHistoryPerawatanLoaded(json: json, statusCode: statusCode, data: json['data']));
    });
  }
}
