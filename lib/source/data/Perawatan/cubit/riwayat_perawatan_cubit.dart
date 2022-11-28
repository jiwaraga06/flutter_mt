import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'riwayat_perawatan_state.dart';

class RiwayatPerawatanCubit extends Cubit<RiwayatPerawatanState> {
  final MyRepository? myRepository;
  RiwayatPerawatanCubit({required this.myRepository}) : super(RiwayatPerawatanInitial());
  void historyPerawatan()async {
    emit(RiwayatPerawatanLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString('email');
    myRepository!.historyPerawatan(email, 1, 5).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('Json History Perawatan: \n $json');
      emit(RiwayatPerawatanLoaded(json: json, statusCode: statusCode));
    });
  }
}
