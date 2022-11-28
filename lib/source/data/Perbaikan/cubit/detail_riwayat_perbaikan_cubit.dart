import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'detail_riwayat_perbaikan_state.dart';

class DetailRiwayatPerbaikanCubit extends Cubit<DetailRiwayatPerbaikanState> {
  final MyRepository? myRepository;
  DetailRiwayatPerbaikanCubit({required this.myRepository})
      : super(DetailRiwayatPerbaikanInitial());

  void getDetailRiwayatPerbaikan(id_penanganan) async {
    emit(DetailRiwayatPerbaikanLoading());
    myRepository!.getDetailRiwayatPerbaikan(id_penanganan).then((value) {
      var json = jsonDecode(value.body);
      var statusCode = value.statusCode;
      print('Detail Riwayat Perbaikan Code: $statusCode');
      print('Detail Riwayat Perbaikan: $json');
      emit(DetailRiwayatPerbaikanLoaded(json: json, statusCode: statusCode));
    });
  }
}
