import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mt/source/repository/repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'riwayat_perbaikan_state.dart';

class RiwayatPerbaikanCubit extends Cubit<RiwayatPerbaikanState> {
  final MyRepository? myRepository;
  RiwayatPerbaikanCubit({required this.myRepository}) : super(RiwayatPerbaikanInitial());

  void getRiwayatPerbaikan() async {
    emit(RiwayatPerbaikanLoading());
    SharedPreferences pref = await SharedPreferences.getInstance();
    var email = pref.getString("email");
    myRepository!.getRiwayatPerbaikan(email, 1, 2).then((value) {
      var json = jsonDecode(value.body);
      print('Status: ${value.statusCode}');
      print('Jsonss: $json');
      if(value.statusCode ==200){
        emit(RiwayatPerbaikanLoaded(json: json));
      }
    });
  }
}
