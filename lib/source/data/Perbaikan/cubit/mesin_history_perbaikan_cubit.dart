import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'mesin_history_perbaikan_state.dart';

class MesinHistoryPerbaikanCubit extends Cubit<MesinHistoryPerbaikanState> {
  final MyRepository? myRepository;
  MesinHistoryPerbaikanCubit({required this.myRepository}) : super(MesinHistoryPerbaikanInitial());

  void getMesinHistoryPerbaikan(id_mesin)async {
    emit(MesinHistoryPerbaikanLoading());
    myRepository!.getMesinHistoryPerbaikan(id_mesin, 1, 5).then((value) {
      var json = jsonDecode(value.body);
      print("JSON_MesinHistory: ${json['data']}");
      emit(MesinHistoryPerbaikanLoaded(json: json, data: json['data'], statusCode: value.statusCode));
    });
  }

}
